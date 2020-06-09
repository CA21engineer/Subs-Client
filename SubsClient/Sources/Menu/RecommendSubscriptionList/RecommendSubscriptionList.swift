//
//  RecommendSubscriptionList.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import Foundation
import ComposableArchitecture

struct RecommendSubscriptionList {
    static let reducer = Reducer<State, Action, AppEnvironment> { state, action, environment in
        switch action {
        case .fetchRecommendSubscriptions:
            return environment.repository
                .fetchSubscriptions() // TODO: fix as recommend
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.recommendSubscriptionsResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case .recommendSubscriptionsResponse(.success(let subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case .recommendSubscriptionsResponse(.failure(let error)):
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
        case fetchRecommendSubscriptions
        case recommendSubscriptionsResponse(Result<[Subscription_Subscription], Error>)
    }
}
