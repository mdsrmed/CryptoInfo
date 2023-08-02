//
//  PortfolioView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/2/23.
//

import SwiftUI


struct PortfolioView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading,spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10){
                            ForEach(vm.allCoins){ coin in
                                CoinLogoView(coin: coin)
                                    .frame(width: 75)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){   
                    XMarkButton()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
