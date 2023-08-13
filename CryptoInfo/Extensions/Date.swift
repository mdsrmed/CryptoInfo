//
//  Date.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/13/23.
//

import Foundation

extension Date {
    //2023-07-14T23:57:35.147Z
    
    init(coinGeckoString: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    
    private var shortFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDataString() -> String{
        return shortFormatter.string(from: self)
    }

}



