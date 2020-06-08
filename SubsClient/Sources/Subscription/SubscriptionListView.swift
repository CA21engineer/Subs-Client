//
//  SubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI

struct SubscriptionListView: View {
    private let subscriptions: [UserSubscription]

    init(subscriptions: [UserSubscription]) {
        self.subscriptions = subscriptions
    }

    var body: some View {
        List {
            ForEach(self.subscriptions) { subscription in
                SubscriptionCardView(subscription: subscription)
                    .padding(.horizontal, -16)
                    .padding(.vertical, -6)
            }
        }
        .edgesIgnoringSafeArea([.bottom])
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct SubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionListView(
            subscriptions: [
                UserSubscription(id: "1", name: "hoge1", serviceType: "1", price: 1, cycle: 1, isOriginal: false),
                UserSubscription(id: "2", name: "hoge2", serviceType: "2", price: 1, cycle: 1, isOriginal: false),
                UserSubscription(id: "3", name: "hoge3", serviceType: "3", price: 1, cycle: 1, isOriginal: false),
                UserSubscription(id: "4", name: "hoge4", serviceType: "4", price: 1, cycle: 1, isOriginal: false),
                UserSubscription(id: "5", name: "hoge5", serviceType: "5", price: 1, cycle: 1, isOriginal: false),
                UserSubscription(id: "6", name: "hoge6", serviceType: "6", price: 1, cycle: 1, isOriginal: false)
            ])
    }
}
