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
            SubscriptionCardView()
        }
    }
}

struct MySubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        MySubscriptionListView(subscriptions: [], cycle: .oneMonth)
    }
}
