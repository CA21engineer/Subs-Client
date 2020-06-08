//
//  SubscriptionCardView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI

struct SubscriptionCardView: View {
    private let subscription: UserSubscription

    init(subscription: UserSubscription) {
        self.subscription = subscription
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image("Netflix_icon")
                    .resizable()
                    .frame(width: 48, height: 48)
                VStack(spacing: 4) {
                    HStack {
                        Text(subscription.name)
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                            .lineLimit(0)
                        Spacer()
                    }
                    HStack {
                        Text("カテゴリー名")
                            .foregroundColor(.gray)
                            .fontWeight(.regular)
                            .font(.system(size: 14))
                            .lineLimit(0)
                        Spacer()
                    }

                }
                Spacer()
                VStack {
                    Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .font(.system(size: 22, weight: .semibold))
                }
                .padding(.trailing, 8)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .background(Color("background1"))

        }
    }
}

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
