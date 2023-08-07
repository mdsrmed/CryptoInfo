//
//  DetailView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/6/23.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    init(coin: CoinModel){
        _vm = StateObject(wrappedValue:DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("It cloudy")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
