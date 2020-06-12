//
//  SubscriptionCreateFormView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import SwiftUI

struct SubscriptionCreateFormView: View {
    private let store: Store<SubscriptionCreateForm.State, SubscriptionCreateForm.Action>
    @State private var showsIconsModal: Bool = false

    init(store: Store<SubscriptionCreateForm.State, SubscriptionCreateForm.Action>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                SubscriptionFormView(
                    store: self.store.scope(
                        state: \.formState,
                        action: {
                            SubscriptionCreateForm.Action.formAction($0)
                        }
                    )
                )
                .navigationBarTitle("登録フォーム", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        viewStore.send(.create)
                    }) {
                        Text("登録")
                    }
                    .disabled(!viewStore.formState.canSend)
                )
            }
        }
    }
}

struct SubscriptionCreateFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubscriptionCreateFormView(
                store: .init(
                    initialState: .init(
                        formState: .init()
                    ),
                    reducer: SubscriptionCreateForm.reducer.debug(),
                    environment: SubscriptionCreateForm.Environment(
                        subscriptionRepository: AppEnvironment.shared.subscriptionRepository,
                        mainQueue: AppEnvironment.shared.mainQueue
                    )
                )
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
