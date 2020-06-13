//
//  MySubscriptionCardView.swift
//  Components
//
//  Created by 長田卓馬 on 2020/06/08.
//

import Core
import SwiftUI

public struct MySubscriptionCardView: View {
    private let userSubscription: Subscription_UserSubscription
    private let monthCount: Int
    @State private var showsDetailModal = false

    init(userSubscription: Subscription_UserSubscription, monthCount: Int) {
        self.userSubscription = userSubscription
        self.monthCount = monthCount
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                if userSubscription.subscription.url != nil {
                    ImageView(image: .init(url: userSubscription.subscription.url!))
                        .cornerRadius(4)
                        .frame(width: 48, height: 48)
                } else {
                    NoImageView()
                        .cornerRadius(4)
                        .frame(width: 48, height: 48)
                }
                VStack(spacing: 4) {
                    HStack {
                        Text(userSubscription.subscription.serviceName)
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                            .lineLimit(0)
                        Spacer()
                    }
                    HStack {
                        Text(userSubscription.subscription.serviceType.title)
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
            .onTapGesture {
                self.showsDetailModal = true
            }
            .sheet(
                isPresented: $showsDetailModal,
                content: {
                    SubscriptionDetailView(
                        store: .init(
                            initialState: .init(userSubscription: self.userSubscription),
                            reducer: SubscriptionDetail.reducer,
                            environment: SubscriptionDetail.Environment(
                                firebaseRepository: AppEnvironment.shared.firebaseRepository,
                                subscriptionRepository: AppEnvironment.shared.subscriptionRepository,
                                mainQueue: AppEnvironment.shared.mainQueue
                            )
                        )
                    )
                }
            )
        }
    }

    private func calculatePrice() -> Int {
        let cycle = userSubscription.subscription.cycle != 0 ? userSubscription.subscription.cycle : 1
        return Int(Int32(monthCount) * userSubscription.subscription.price / cycle)
    }
}

#if DEBUG

    struct MySubscriptionCardView_Previews: PreviewProvider {
        static var previews: some View {
            MySubscriptionCardView(
                userSubscription: .with {
                    $0.userSubscriptionID = "1"
                    $0.subscription = .init()
                },
                monthCount: 1
            )
        }
    }

#endif
