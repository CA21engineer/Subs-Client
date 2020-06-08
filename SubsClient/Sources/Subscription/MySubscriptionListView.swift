//
//  MySubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import SwiftUI

struct MySubscriptionListView: View {
    private let subscriptions: [Subscription_Subscription]
    private let tab: HomeTab

    init(subscriptions: [Subscription_Subscription], tab: HomeTab) {
        self.subscriptions = subscriptions
        self.tab = tab
    }

    var body: some View {
        // TODO: insert header
        List {
            ForEach(self.subscriptions) { subscription in
                MySubscriptionCardView(subscription: subscription)
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

struct MySubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        MySubscriptionListView(
            subscriptions: [],
            tab: .oneMonth)
    }
}
