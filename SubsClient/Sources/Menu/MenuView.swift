//
//  MenuView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import ComposableArchitecture
import Core
import SwiftUI

struct MenuView: View {
    @State private var selectedTabIndex = 0
    @State private var showModal: Bool = false
    private let tabs = MenuTab.allCases
    @Environment(\.presentationMode) var presentationMode

    private let store = Store<Menu.State, Menu.Action>(
        initialState: Menu.State(),
        reducer: Menu.reducer,
        environment: Menu.Environment(
            firebaseRepository: AppEnvironment.shared.firebaseRepository,
            recommendSubscriptionsRepository: AppEnvironment.shared.recommendSubscriptionsRepository,
            popularSubscriptionsRepository: AppEnvironment.shared.popularSubscriptionsRepository,
            mainQueue: AppEnvironment.shared.mainQueue
        )
    )

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor.systemBackground
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading) {
                SlidingTabView(selection: self.$selectedTabIndex, tabs: self.tabs.map { $0.title })
                if self.selectedTabIndex == 0 {
                    RecommendSubscriptionListView(subscriptions: viewStore.recommendSubscriptions)
                } else if self.selectedTabIndex == 1 {
                    PopularSubscriptionListView(subscriptions: viewStore.popularSubscriptions)
                }
            }
            .navigationBarTitle("選択する", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showModal = true
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 20))
                    })
                    .sheet(
                        isPresented: self.$showModal,
                        content: {
                            SubscriptionCreateView(
                                store: .init(
                                    initialState: .init(),
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
            )
            .onAppear {
                viewStore.send(.fetchRecommendSubscriptions)
                viewStore.send(.fetchPopularSubscriptions)
            }
            .onReceive(Home.reloadSubject.eraseToAnyPublisher()) { _ in
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
