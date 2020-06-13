//
//  SubscriptionForm.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import ComposableArchitecture
import Foundation

struct SubscriptionForm {
    private static let yen = "¥"

    struct State: Equatable {
        var subscriptionID: String = ""
        var iconID: String = ""
        var imageURL: URL?
        var price: Int = 0
        var serviceName: String = ""
        var cycle: Int = 1
        var startedAt: Date = Date()
        var isOriginal: Bool = false

        init() {}

        init(subscription: Subscription_Subscription) {
            subscriptionID = subscription.subscriptionID
            imageURL = subscription.url
            price = Int(subscription.price)
            serviceName = subscription.serviceName
            cycle = Int(subscription.cycle)
            isOriginal = subscription.isOriginal
        }

        var canSend: Bool {
            isValidToSend(state: self)
        }
    }

    enum Action {
        case changeIcon(String, URL)
        case changePrice(Int)
        case changeServiceName(String)
        case changeCycle(Int)
        case changeStartedAt(Date)
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, _ in
        switch action {
        case let .changeIcon(iconID, iconURL):
            state.iconID = iconID
            state.imageURL = iconURL
        case let .changePrice(price):
            state.price = price
        case let .changeServiceName(serviceName):
            state.serviceName = serviceName
        case let .changeCycle(cycle):
            state.cycle = cycle
        case let .changeStartedAt(startedAt):
            state.startedAt = startedAt
        }
        return .none
    }
    .debug()
    .debugActions()

    struct Environment {}

    struct ID: Hashable {}

    private static func isValidToSend(state: State) -> Bool {
        !state.iconID.isEmpty
            && !state.serviceName.isEmpty
    }
}
