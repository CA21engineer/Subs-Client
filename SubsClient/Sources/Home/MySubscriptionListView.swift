//
//  MySubscriptionListView.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import Core
import SwiftUI

struct MySubscriptionListView: View {
    private let userSubscriptions: [Subscription_UserSubscription]
    private let tab: HomeTab

    init(userSubscriptions: [Subscription_UserSubscription], tab: HomeTab) {
        self.userSubscriptions = userSubscriptions
        self.tab = tab
    }

    var body: some View {
        List {
            Section(
                header: SumCostView(
                    cost: calculateTotalCost(),
                    count: userSubscriptions.count,
                    tab: tab
                )
                .padding(.horizontal, -16)
            ) {
                ForEach(self.userSubscriptions) { userSubscription in
                    MySubscriptionCardView(
                        userSubscription: userSubscription,
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
        let costs = userSubscriptions.map { userSubscription -> Int in
            let cycle = userSubscription.subscription.cycle != 0 ? userSubscription.subscription.cycle : 1
            return Int(Int32(self.tab.monthCount) * userSubscription.subscription.price / cycle)
        }
        return costs.reduce(0, +)
    }
}

struct MySubscriptionListView_Previews: PreviewProvider {
    static var previews: some View {
        MySubscriptionListView(
            userSubscriptions: [
                Subscription_UserSubscription.with {
                    $0.subscription = Subscription_Subscription.with { subscription in
                        subscription.price = 800
                        subscription.serviceName = "Netflix"
                        subscription.iconUri = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F75%2FNetflix_icon.svg%2F1200px-Netflix_icon.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANetflix_icon.svg&tbnid=FPQrcmY85Qu9sM&vet=12ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ..i&docid=bpNS0lmfVwcz2M&w=1200&h=1200&q=netflix%20icon&ved=2ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ"
                    }
                },
                Subscription_UserSubscription.with {
                    $0.subscription = Subscription_Subscription.with { subscription in
                        subscription.price = 800
                        subscription.serviceName = "Netflix"
                        subscription.iconUri = "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2F7%2F75%2FNetflix_icon.svg%2F1200px-Netflix_icon.svg.png&imgrefurl=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANetflix_icon.svg&tbnid=FPQrcmY85Qu9sM&vet=12ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ..i&docid=bpNS0lmfVwcz2M&w=1200&h=1200&q=netflix%20icon&ved=2ahUKEwjOyNPj5fvpAhUWzYsBHZSXDEkQMygBegUIARClAQ"
                    }
                },
            ],
            tab: .oneMonth
        )
        .environment(\.colorScheme, .light)
    }
}
