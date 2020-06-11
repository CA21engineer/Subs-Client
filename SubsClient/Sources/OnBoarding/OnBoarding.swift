//
//  OnBoarding.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/10.
//

import ComposableArchitecture
import Foundation

struct OnBoarding {
    static let reducer = Reducer<State, Action, AppEnvironment> { state, action, environment in
        switch action {
        case .fetchSubscriptions:
//            return environment.repository
//                .fetchSubscriptions()
//                .receive(on: environment.mainQueue)
//                .catchToEffect()
//                .map(Action.recommendSubscriptionsResponse)
//                .cancellable(id: ID(), cancelInFlight: true)
            return .init(value: .subscriptionsResponse(.success([])))
        case let .subscriptionsResponse(.success(subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case let .subscriptionsResponse(.failure(error)):
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
        case fetchSubscriptions
        case subscriptionsResponse(Result<[Subscription_Subscription], Error>)
    }
}