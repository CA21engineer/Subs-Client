//
//  OnBoardingSubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/10.
//

import ComposableArchitecture
import SwiftUI

struct OnBoardingSubscriptionListView: View {
    private let store: Store<OnBoarding.State, OnBoarding.Action>

    init(store: Store<OnBoarding.State, OnBoarding.Action>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                ForEach(viewStore.subscriptions) { subscription in
                    SubscriptionCardView(subscription: subscription)
                        .padding(.horizontal, -16)
                        .padding(.vertical, -6)
                }
            }
            .edgesIgnoringSafeArea([.bottom])
            .onAppear {
                viewStore.send(.fetchSubscriptions)
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
}

struct OnBoardingSubscriptionListView_Previews: PreviewProvider {
    private static let store = Store(
        initialState: OnBoarding.State(),
        reducer: OnBoarding.reducer,
        environment: OnBoarding.Environment(
            subscriptionsRepository: AppEnvironment.shared.subscriptionsRepository,
            mainQueue: AppEnvironment.shared.mainQueue
        )
    )

    static var previews: some View {
        OnBoardingSubscriptionListView(store: store)
    }
}
