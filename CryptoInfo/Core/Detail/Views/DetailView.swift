//
//  DetailView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/6/23.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat  = 30
    
    init(coin: CoinModel){
        _vm = StateObject(wrappedValue:DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {    
                    Text("Overview")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    
                    LazyVGrid(columns: columns,
                              alignment: .leading,
                              spacing: spacing) {
                        ForEach(vm.overviewStatistics){ stat in
                            StatisticView(stat: stat)
                        }
                    }
                    
                    Text("Additional Details")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.theme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    
                    LazyVGrid(columns: columns,
                              alignment: .leading,
                              spacing: spacing) {
                        ForEach(vm.additionalStatistics){ stat in
                            StatisticView(stat: stat)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                HStack {
                    Text(vm.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    CoinImageView(coin: vm.coin)
                        .frame(width: 50,height: 50)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
