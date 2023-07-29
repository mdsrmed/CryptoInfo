//
//  UIApplication.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/29/23.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
