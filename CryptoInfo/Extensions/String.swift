//
//  String.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/14/23.
//

import Foundation


extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "",  options: .regularExpression, range: nil)
    }
}
