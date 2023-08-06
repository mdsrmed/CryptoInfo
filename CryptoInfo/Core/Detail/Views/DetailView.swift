//
//  DetailView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 8/6/23.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
