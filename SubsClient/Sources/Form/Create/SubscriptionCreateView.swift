//
//  SubscriptionCreateFormView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import Core
import SwiftUI

struct SubscriptionCreateView: View {
    private let store: Store<SubscriptionCreate.State, SubscriptionCreate.Action>
    @State private var showsIconsModal: Bool = false
    @Environment(\.presentationMode) var presentationMode

    init(store: Store<SubscriptionCreate.State, SubscriptionCreate.Action>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    SubscriptionFormView(
                        store: self.store.scope(
                            state: \.formState,
                            action: {
                                SubscriptionCreate.Action.formAction($0)
                            }
                        )
                    )
                    Spacer()
                }
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
            .onReceive(Home.reloadSubject.eraseToAnyPublisher()) { _ in
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SubscriptionCreateFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubscriptionCreateView(
                store: .init(
                    initialState: .init(
                        subscription: Subscription_Subscription.with { subscription in
                            subscription.price = 800
                            subscription.serviceName = "Netflix"
                            subscription.iconUri = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F75%2FNetflix_icon.svg%2F1200px-Netflix_icon.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANetflix_icon.svg&tbnid=FPQrcmY85Qu9sM&vet=12ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ..i&docid=bpNS0lmfVwcz2M&w=1200&h=1200&q=netflix%20icon&ved=2ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ"
                        }
                    ),
                    reducer: SubscriptionCreate.reducer.debug(),
                    environment: SubscriptionCreate.Environment(
                        subscriptionRepository: AppEnvironment.shared.subscriptionRepository,
                        firebaseRepository: AppEnvironment.shared.firebaseRepository,
                        mainQueue: AppEnvironment.shared.mainQueue
                    )
                )
            )
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
        }
    }
}
