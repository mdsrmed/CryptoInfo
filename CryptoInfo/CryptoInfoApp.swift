//
//  CryptoInfoApp.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/13/23.
//

import SwiftUI

@main
struct CryptoInfoApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
