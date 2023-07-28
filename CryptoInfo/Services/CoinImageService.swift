//
//  CoinImageService.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/27/23.
//

import Foundation
import SwiftUI
import Combine



class CoinImageService {
    
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.shared
    private let folderName = "coin_images"
    private let imageName: String
    
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
        
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                guard let self = self,let downloadedImage = image else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.savaImage(image: downloadedImage, folderName: folderName, imageName: imageName)
            })
            
        
    }
}
