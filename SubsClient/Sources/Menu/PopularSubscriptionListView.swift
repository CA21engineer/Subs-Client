//
//  PopularSubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Core
import SwiftUI

struct PopularSubscriptionListView: View {
    private let subscriptions: [Subscription_Subscription]

    init(subscriptions: [Subscription_Subscription]) {
        self.subscriptions = subscriptions
    }

    var body: some View {
        List {
            ForEach(subscriptions) { subscription in
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

struct PopularSubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        PopularSubscriptionListView(subscriptions: [])
    }
}
