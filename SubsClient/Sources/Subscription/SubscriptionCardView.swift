//
//  SubscriptionCardView.swift
//  Components
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI

public struct SubscriptionCardView: View {

    private let subscription: UserSubscription

    init(subscription: UserSubscription) {
        self.subscription = subscription
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                Text(subscription.name)
                    .fontWeight(.semibold)
                    .lineLimit(0)
                Spacer()
                Text(String(subscription.price))
                    .fontWeight(.semibold)
                    .lineLimit(0)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .background(Color("background1"))
            .cornerRadius(8)
            
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .background(Color("background0"))
    }
}

#if DEBUG

struct SubscriptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCardView(
            subscription: UserSubscription(
                id: "1",
                name: "hoge",
                serviceType: "1",
                price: 1,
                cycle: 1,
                isOriginal: false)
        )
    }
}

#endif
