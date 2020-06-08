//
//  Home.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import Foundation
import ComposableArchitecture

struct Home {
    static let reducer = Reducer<State, Action, AppEnvironment> { state, action, environment in
        switch action {
        case .fetchSubscriptions:
            return environment.repository
                .fetchMySubscriptions(accountID: "")
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.subscriptionResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case .subscriptionResponse(.success(let subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case .subscriptionResponse(.failure(let error)):
            state.subscriptions = []
            return .none
        }
    }

    struct ID: Hashable {}

    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.subscriptions == rhs.subscriptions
        }

        var subscriptions: [Subscription_Subscription] = []
    }

    enum Action {
        case fetchSubscriptions
        case subscriptionResponse(Result<[Subscription_Subscription], Error>)
    }
}
