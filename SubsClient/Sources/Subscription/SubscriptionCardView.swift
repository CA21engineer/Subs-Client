//
//  SubscriptionCardView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI

struct SubscriptionCardView: View {
    private let subscription: Subscription_Subscription
    @State private var showsCreateModal = false

    init(subscription: Subscription_Subscription) {
        self.subscription = subscription
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                if subscription.url != nil {
                    ImageView(image: .init(url: subscription.url!))
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
                VStack {
                    Button(action: {
                        self.showsCreateModal = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.primary)
                            .font(.system(size: 22, weight: .semibold))
                    })
                        .sheet(
                            isPresented: self.$showsCreateModal,
                            content: {
                                SubscriptionCreateView(
                                    store: .init(
                                        initialState: .init(subscription: self.subscription),
                                        reducer: SubscriptionCreate.reducer,
                                        environment: SubscriptionCreate.Environment(
                                            subscriptionRepository: AppEnvironment.shared.subscriptionRepository,
                                            firebaseRepository: AppEnvironment.shared.firebaseRepository,
                                            mainQueue: AppEnvironment.shared.mainQueue
                                        )
                                    )
                                )
                            }
                        )
                }
                .padding(.trailing, 8)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct SubscriptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionCardView(subscription: Subscription_Subscription())
    }
}
