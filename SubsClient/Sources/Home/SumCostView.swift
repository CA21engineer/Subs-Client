//
//  SumCostView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/12.
//

import SwiftUI

struct SumCostView: View {
    let cost: Int
    let count: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("¥\(cost)")
                    .font(.largeTitle)
                    .foregroundColor(Color(UIColor.label))
                Spacer()
            }
            Divider()
            HStack {
                Text("サブスク数")
                Spacer()
                Text("\(count)")
            }
            .foregroundColor(Color(UIColor.secondaryLabel))
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct SumCostView_Previews: PreviewProvider {
    static var previews: some View {
        SumCostView(
            cost: 3000,
            count: 10
        )
        .previewLayout(.sizeThatFits)
    }
}
