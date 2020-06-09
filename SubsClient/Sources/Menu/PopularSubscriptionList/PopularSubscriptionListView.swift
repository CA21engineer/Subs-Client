//
//  PopularSubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import SwiftUI
import ComposableArchitecture

struct PopularSubscriptionListView: View {
    private let store: Store<PopularSubscriptionList.State, PopularSubscriptionList.Action>

    init(store: Store<PopularSubscriptionList.State, PopularSubscriptionList.Action>) {
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
//                viewStore.send(.fetchPopularSubscriptions)
                UITableView.appearance().separatorStyle = .none
            }
        }
    }
}

struct PopularSubscriptionListView_Previews: PreviewProvider {
    static private let store = Store(
        initialState: PopularSubscriptionList.State(),
        reducer: PopularSubscriptionList.reducer,
        environment: AppEnvironment(
            repository: Repository(),
            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
        )
    )

    static var previews: some View {
        PopularSubscriptionListView(store: store)
    }
}
