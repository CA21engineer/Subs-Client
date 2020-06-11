//
//  MenuView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import ComposableArchitecture
import SwiftUI

struct MenuView: View {
    @State private var selectedTabIndex = 0
    @State private var showModal: Bool = false
    private let tabs = MenuTab.allCases

    private let recommendStore = Store(
        initialState: RecommendSubscriptionList.State(),
        reducer: RecommendSubscriptionList.reducer,
        environment: RecommendSubscriptionList.Environment(
            recommendSubscriptionsRepository: AppEnvironment.shared.recommendSubscriptionsRepository,
            mainQueue: AppEnvironment.shared.mainQueue
        )
    )

    private let popularStore = Store(
        initialState: PopularSubscriptionList.State(),
        reducer: PopularSubscriptionList.reducer,
        environment: PopularSubscriptionList.Environment(
            popularSubscriptionsRepository: AppEnvironment.shared.popularSubscriptionsRepository,
            mainQueue: AppEnvironment.shared.mainQueue
        )
    )

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "background1")
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SlidingTabView(selection: $selectedTabIndex, tabs: tabs.map { $0.title })
                if selectedTabIndex == 0 {
                    RecommendSubscriptionListView(store: recommendStore)
                } else if selectedTabIndex == 1 {
                    PopularSubscriptionListView(store: popularStore)
                }
            }
            .navigationBarTitle("選択する", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showModal = true
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                })
                    .sheet(
                        isPresented: self.$showModal,
                        content: {
                            SubscriptionFormView(
                                store: .init(
                                    initialState: .init(),
                                    reducer: SubscriptionForm.reducer,
                                    environment: .shared
                                )
                            )
                        }
                    )
            )
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
