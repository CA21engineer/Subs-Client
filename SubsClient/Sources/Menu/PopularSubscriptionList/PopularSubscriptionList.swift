//
//  PopularSubscriptionList.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Foundation

struct PopularSubscriptionList {
    static let reducer = Reducer<State, Action, AppEnvironment> { state, action, environment in
        switch action {
        case .fetchPopularSubscriptions:
//            return environment.repository
//                .fetchSubscriptions() // TODO: fix as popular
//                .receive(on: environment.mainQueue)
//                .catchToEffect()
//                .map(Action.popularSubscriptionsResponse)
//                .cancellable(id: ID(), cancelInFlight: true)
            return .init(value: .popularSubscriptionsResponse(.success([])))
        case let .popularSubscriptionsResponse(.success(subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case let .popularSubscriptionsResponse(.failure(error)):
            state.subscriptions = []
            return .none
        }
    }.debug()

    struct ID: Hashable {}

    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.subscriptions == rhs.subscriptions
        }

        var subscriptions: [Subscription_Subscription] = []
    }

    enum Action {
        case fetchPopularSubscriptions
        case popularSubscriptionsResponse(Result<[Subscription_Subscription], Error>)
    }
}
