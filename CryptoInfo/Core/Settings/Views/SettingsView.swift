//
//  SettingsView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/15/23.
//

import SwiftUI

struct SettingsView: View {
    
    let githubURL = URL(string: "https://www.github.com/mdsrmed")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let defaultURL = URL(string: "https://www.google.com")!
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("CryptoInfo")){
                    VStack(alignment: .leading){
                        Image("crypto-info")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("This app was made by using Coingecko API.It uses MVVM Architecture, Combine and CoreData.")
                    }
                    .padding(.vertical)
                    Link("Coingecko", destination: coingeckoURL)
                }
                
                Section(header: Text("Developer")){
                    VStack(alignment: .leading){
                        Image("developer")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("This app was developed by Md Shohidur Rahman.It uses SwiftUI and is written 100% in Swift.The project benefits from multi-threading,publishers/subscriber and data persistence.")
                    }
                    .padding(.vertical)
                    Link("Visit github", destination: githubURL)
                }
                
                Section(header: Text("Applications")){
                    Link("Terms of Services", destination: defaultURL)
                    Link("Privacy Policy", destination: defaultURL)
                    Link("Company Website", destination: defaultURL)
                    Link("Learn More", destination: defaultURL)
                }
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
          
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
