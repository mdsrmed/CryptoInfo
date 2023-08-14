//
//  DetailViewModel.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/7/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel]  = []
    @Published var additionalStatistics: [StatisticModel]  = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    @Published var  coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ (CoinDetailModel,coinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) in
                
                // overview
                let price = coinModel.currentPrice.asCurrencyWith4Decimals()
                let pricePercentChange = coinModel.priceChangePercentage24H
                let priceStat = StatisticModel( title: "Current Price", value: price, percentageChange: pricePercentChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChange)
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticModel(title: "Rank", value: rank)
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = StatisticModel(title: "Volume", value: volume)
                
                let overviewArray: [StatisticModel] = [
                priceStat, marketCapStat,rankStat, volumeStat]
                
                
                // additional
                let high = coinModel.high24H?.asCurrencyWith4Decimals() ?? "n/a"
                let highStat = StatisticModel(title: "24h High", value: high)
                let low = coinModel.low24H?.asCurrencyWith4Decimals() ?? "n/a"
                let lowStat = StatisticModel(title: "24h Low", value: low)
                let priceChange = coinModel.priceChange24H?.asCurrencyWith4Decimals() ?? "n/a"
                let pricePercentChange2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange2)
                let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange:
                    marketCapPercentChange2)
                let blockTime = CoinDetailModel?.blockTimeInMinutes // 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
                let hashing = CoinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
                
                
                let additionalArray: [StatisticModel] = [
                    highStat,lowStat,priceChangeStat,marketCapChangeStat,blockStat,hashingStat
                ]
                
                return (overviewArray,additionalArray)
            })
            .sink {[weak self] returnedArrays  in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
                
            }
            .store(in: &cancellables)
        
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
}
