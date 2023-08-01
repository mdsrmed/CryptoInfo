//
//  MarketDataService.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/1/23.
//

import Foundation
import Combine


class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    private var marketDataSubscription: AnyCancellable?
    
    
    init(){
        
         getData()
    }
    
    private func getData(){
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription =  NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] globalData in
                guard let self = self else { return }
                self.marketData = globalData.data
                self.marketDataSubscription?.cancel()
            })
            

    }
}
