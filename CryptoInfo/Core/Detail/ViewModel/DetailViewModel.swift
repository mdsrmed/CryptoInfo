//
//  DetailViewModel.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/7/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails  in
                
            }
            .store(in: &cancellables)
    }
}
