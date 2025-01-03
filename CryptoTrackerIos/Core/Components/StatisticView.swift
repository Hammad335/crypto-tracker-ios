//
//  StatisticView.swift
//  CryptoTrackerIos
//
//  Created by Hamad on 19/12/2024.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.accent)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(
                            degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))

                Text(stat.percentageChange?.asPercentString() ?? " ")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ?
                Color.theme.green : Color.theme.red)
            .opacity((stat.percentageChange ?? 0) == 0 ? 0 : 1)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: DeveloperPreview.instance.stat1)
}
