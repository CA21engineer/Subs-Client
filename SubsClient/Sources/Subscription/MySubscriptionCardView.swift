//
//  MySubscriptionCardView.swift
//  Components
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI

public struct MySubscriptionCardView: View {
    private let subscription: Subscription_Subscription
    private let calculateParam: Int

    init(subscription: Subscription_Subscription, calculateParam: Int) {
        self.subscription = subscription
        self.calculateParam = calculateParam
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                if subscription.url != nil {
                    ImageView(image: .init(url: subscription.url!))
                        .cornerRadius(4)
                        .frame(width: 48, height: 48)
                    NoImageView()
                        .cornerRadius(4)
                        .frame(width: 48, height: 48)
                } else {
                    NoImageView()
                        .cornerRadius(4)
                        .frame(width: 48, height: 48)
                }
                VStack(spacing: 4) {
                    HStack {
                        Text(subscription.serviceName)
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
                Text("¥\(calculatePrice())")
                    .fontWeight(.semibold)
                    .lineLimit(0)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
    }

    private func calculatePrice() -> Int {
        Int(Int32(calculateParam) * subscription.price / subscription.cycle)
    }
}

#if DEBUG

    struct MySubscriptionCardView_Previews: PreviewProvider {
        static var previews: some View {
            MySubscriptionCardView(
                subscription: Subscription_Subscription(),
                calculateParam: 1
            )
        }
    }

#endif
