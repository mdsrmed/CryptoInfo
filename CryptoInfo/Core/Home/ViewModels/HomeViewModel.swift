//
//  HomeViewModel.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/23/23.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var  statistics: [StatisticModel] = []
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
//        StatisticModel(title: "value", value:"11.4Bn",percentageChange: 1),
//        StatisticModel(title: "value", value:"11.4Bn",percentageChange: 1),
//        StatisticModel(title: "value", value:"11.4Bn",percentageChange: 1),
//        StatisticModel(title: "value", value:"11.4Bn",percentageChange: -11),

    
    private var cancellables = Set<AnyCancellable>()
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init(){
        addSubscriber()
    }
    
    
    func addSubscriber(){
        
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for:  .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map (mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map{(coinModels, portfolioEntities) -> [CoinModel] in
                
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)

    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePorfolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filteredAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filteredCoins(text: text, coins: coins)
        sortCoins(sort: sort , coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]){
        switch sort{
        case .rank, .holdings:
            //            return coins.sorted { (coin1, coin2) -> Bool in
            //                return coin1.rank < coin2.rank
             coins.sort(by:{ $0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
             coins.sort(by:{ $0.rank > $1.rank})
        case .price:
            coins.sort(by: { $0.currentPrice < $1.currentPrice})
        case .priceReversed:
             coins.sort(by:{$0.currentPrice > $1.currentPrice})
        }
               
            
    }
    
    private func sortPortfolioCoinsIfNeeded( coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }
    
    private func filteredCoins( text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange:
                                        data.marketCapChangePercentage24HUsd)
    
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map { (coin) -> Double in
            return coin.currentHoldingsValue
            }
            .reduce(0,+)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0.0 / 100
                let previousValue = currentValue  / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith4Decimals(),
                                       percentageChange: percentageChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
                     
        return stats
    }
}

