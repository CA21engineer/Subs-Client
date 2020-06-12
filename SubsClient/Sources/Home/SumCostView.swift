//
//  SumCostView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/12.
//

import SwiftUI

struct SumCostView: View {
    private let cost: Int
    private let count: Int
    private let tab: HomeTab

    init(cost: Int, count: Int, tab: HomeTab) {
        self.cost = cost
        self.count = count
        self.tab = tab
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(spacing: 8) {
                Text("合計金額")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))

                HStack {
                    Spacer()
                    Text("¥\(cost)")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                    Text("/\(tab.headerTitle)")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .padding(.top, 4)
                    Spacer()
                }
                .padding(.leading, 16)
            }
            Rectangle()
                .fill(Color.white)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)

            HStack {
                Text("登録しているサービスの数")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("\(count)件")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.top, 4)
            .foregroundColor(Color(UIColor.secondaryLabel))
        }
        .padding()
        .background(Color(Asset.Assets.primaryHeader.color))
        .cornerRadius(8)
        .padding(.horizontal, 16)
        .background(Color(UIColor.systemBackground))
    }
}

struct SumCostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SumCostView(
                cost: 3000,
                count: 10,
                tab: .oneMonth
            )
            .padding()
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)

            SumCostView(
                cost: 3000,
                count: 10,
                tab: .oneMonth
            )
            .padding()
            .background(Color(UIColor.systemBackground))
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
