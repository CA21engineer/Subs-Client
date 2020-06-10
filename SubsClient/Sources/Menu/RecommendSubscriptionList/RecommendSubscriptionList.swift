//
//  RecommendSubscriptionList.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Foundation

struct RecommendSubscriptionList {
    static let reducer = Reducer<State, Action, AppEnvironment> { state, action, environment in
        switch action {
        case .fetchRecommendSubscriptions:
//            return environment.repository
//                .fetchSubscriptions() // TODO: fix as recommend
//                .receive(on: environment.mainQueue)
//                .catchToEffect()
//                .map(Action.recommendSubscriptionsResponse)
//                .cancellable(id: ID(), cancelInFlight: true)
            return .init(value: .recommendSubscriptionsResponse(.success([])))
        case let .recommendSubscriptionsResponse(.success(subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case let .recommendSubscriptionsResponse(.failure(error)):
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
        case fetchRecommendSubscriptions
        case recommendSubscriptionsResponse(Result<[Subscription_Subscription], Error>)
    }
}
