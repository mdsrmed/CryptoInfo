//
//  CoinImageViewModel.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/27/23.
//

import Foundation
import SwiftUI
import Combine


class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let coin: CoinModel
    private let dataService: CoinImageService
    
    init(coin: CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                
                self?.image = image
            }
            .store(in: &cancellables)

    }
}
