//
//  HomeStatsView.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 19/12/2024.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject var vm: HomeViewModel

    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            ForEach(vm.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(true))
        .environmentObject(DeveloperPreview.instance.homeViewModel)
}
