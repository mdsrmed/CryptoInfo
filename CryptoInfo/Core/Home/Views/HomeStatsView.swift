//
//  HomeStatsView.swift
//  CryptoInfo
//
//  Created by Md Shohidur Rahman on 7/31/23.
//

import SwiftUI

struct HomeStatsView: View {
    
    @Binding var showPortfolio: Bool
    @EnvironmentObject var vm: HomeViewModel
   
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
