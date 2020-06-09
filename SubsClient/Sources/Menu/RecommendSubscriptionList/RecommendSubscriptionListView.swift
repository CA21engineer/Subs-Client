//
//  RecommendSubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import ComposableArchitecture
import SwiftUI

struct RecommendSubscriptionListView: View {
    private let store: Store<RecommendSubscriptionList.State, RecommendSubscriptionList.Action>

    init(store: Store<RecommendSubscriptionList.State, RecommendSubscriptionList.Action>) {
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
//                viewStore.send(.fetchRecommendSubscriptions)
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
}

struct RecommendSubscriptionListView_Previews: PreviewProvider {
    private static let store = Store(
        initialState: RecommendSubscriptionList.State(),
        reducer: RecommendSubscriptionList.reducer,
        environment: AppEnvironment.shared
    )

    static var previews: some View {
        RecommendSubscriptionListView(store: store)
    }
}
