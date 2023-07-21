//
//  Double.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/20/23.
//

import Foundation


extension Double {
    
    /// Converts a Double into a Currency with 2-4 decimal places
    /// ```
    /// Convert 1230.45 to $1,230.45
    /// ```
    private var currencyFormatter4: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        //formatter.locale = .current
        //formatter.currencyCode = "usd"
        //formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 4
        return formatter
    }
    /// Converts a Double into a Currency as a String with 2-4 decimal places
    /// ```
    /// Convert 1230.45 to "$1,230.45"
    /// ```
    func asCurrencyWith4Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter4.string(from: number) ?? "0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
     }
}
