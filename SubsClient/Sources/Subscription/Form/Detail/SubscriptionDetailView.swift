//
//  SubscriptionDetailView.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import SwiftUI

struct SubscriptionDetailView: View {
    let store: Store<SubscriptionDetail.State, SubscriptionDetail.Action>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    SubscriptionFormView(
                        store: self.store.scope(
                            state: \.formState,
                            action: {
                                SubscriptionDetail.Action.formAction($0)
                            }
                        )
                    )
                    Button(action: {
                        viewStore.send(.unregister)
                    }) {
                        Text("登録解除する")
                            .foregroundColor(Color.red)
                            .underline()
                    }
                    Spacer()
                }
                .navigationBarTitle("詳細", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        viewStore.send(.update)
                    }) {
                        Text("更新")
                    }
                    .disabled(!viewStore.formState.canSend)
                )
            }
        }
    }
}

struct SubscriptionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionDetailView(
            store: .init(
                initialState: .init(
                    subscription: Subscription_Subscription.with { subscription in
                        subscription.price = 800
                        subscription.serviceName = "Netflix"
                        subscription.iconUri = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F75%2FNetflix_icon.svg%2F1200px-Netflix_icon.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANetflix_icon.svg&tbnid=FPQrcmY85Qu9sM&vet=12ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ..i&docid=bpNS0lmfVwcz2M&w=1200&h=1200&q=netflix%20icon&ved=2ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ"
                    }
                ),
                reducer: SubscriptionDetail.reducer,
                environment: SubscriptionDetail.Environment(
                    firebaseRepository: AppEnvironment.shared.firebaseRepository,
                    subscriptionRepository: AppEnvironment.shared.subscriptionRepository,
                    mainQueue: AppEnvironment.shared.mainQueue
                )
            )
        )
    }
}
