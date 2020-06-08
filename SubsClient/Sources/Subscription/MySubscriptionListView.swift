//
//  MySubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI
import Components

enum Cycle {
    case oneMonth
    case threeMonth
    case halfYear
    case oneYear
}

struct UserSubscription: Identifiable {
    let id: String
    let name: String
    let serviceType: String
    let price: Int
    let cycle: Int
    let isOriginal: Bool
}

struct MySubscriptionListView: View {
    let subscriptions: [UserSubscription]
    let cycle: Cycle

    init(subscriptions: [UserSubscription], cycle: Cycle) {
        self.subscriptions = subscriptions
        self.cycle = cycle
    }

    var body: some View {
        // TODO: insert header
        List(self.subscriptions) { subscription in
            SubscriptionCardView(subscription: subscription)
                .padding(.horizontal, -16)
                .padding(.vertical, -6)

        }
        .edgesIgnoringSafeArea([.bottom])
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
}

struct MySubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        MySubscriptionListView(subscriptions: [UserSubscription(id: "1", name: "hoge1", serviceType: "1", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "2", name: "hoge2", serviceType: "2", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "3", name: "hoge3", serviceType: "3", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "4", name: "hoge4", serviceType: "4", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "5", name: "hoge5", serviceType: "5", price: 1, cycle: 1, isOriginal: false),
        UserSubscription(id: "6", name: "hoge6", serviceType: "6", price: 1, cycle: 1, isOriginal: false)], cycle: .oneMonth)
    }
}
