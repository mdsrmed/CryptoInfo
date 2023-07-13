//
//  CryptoInfoApp.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/13/23.
//

import SwiftUI

@main
struct CryptoInfoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
