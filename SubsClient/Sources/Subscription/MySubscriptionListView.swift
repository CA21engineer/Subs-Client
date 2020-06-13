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
        List {
            Section(
                header: SumCostView(
                    cost: calculateTotalCost(),
                    count: subscriptions.count,
                    tab: tab
                )
                .padding(.horizontal, -16)
            ) {
                ForEach(self.subscriptions) { subscription in
                    MySubscriptionCardView(
                        subscription: subscription,
                        monthCount: self.tab.monthCount
                    )
                    .padding(.horizontal, -16)
                    .padding(.vertical, -6)
                }
            }
        }
        .edgesIgnoringSafeArea([.bottom])
        .onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }

    private func calculateTotalCost() -> Int {
        let costs = subscriptions.map { subscription -> Int in
            Int(Int32(self.tab.monthCount) * subscription.price / subscription.cycle)
        }
        return costs.reduce(0, +)
    }
}

struct MySubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        MySubscriptionListView(
            subscriptions: [
                Subscription_Subscription.with { subscription in
                    subscription.price = 800
                    subscription.serviceName = "Netflix"
                    subscription.iconUri = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F75%2FNetflix_icon.svg%2F1200px-Netflix_icon.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANetflix_icon.svg&tbnid=FPQrcmY85Qu9sM&vet=12ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ..i&docid=bpNS0lmfVwcz2M&w=1200&h=1200&q=netflix%20icon&ved=2ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ"
                },
                Subscription_Subscription.with { subscription in
                    subscription.price = 800
                    subscription.serviceName = "Netflix"
                    subscription.iconUri = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F75%2FNetflix_icon.svg%2F1200px-Netflix_icon.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANetflix_icon.svg&tbnid=FPQrcmY85Qu9sM&vet=12ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ..i&docid=bpNS0lmfVwcz2M&w=1200&h=1200&q=netflix%20icon&ved=2ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ"
                },
            ],
            tab: .oneMonth
        )
        .environment(\.colorScheme, .light)
    }
}
