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
    
    private var cancellables = Set<AnyCancellable>()
    
    private let dataService = CoinDataService()
    
    init(){
        addSubscriber()
    }
    
    
    func addSubscriber(){
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}

