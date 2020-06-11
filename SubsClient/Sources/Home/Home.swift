//
//  Home.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Foundation

struct Home {
    static let reducer = Reducer<State, Action, Environment> { state, action, _ in
        switch action {
        case .fetchMySubscriptions:
//            return environment.repository
//                .fetchMySubscriptions(accountID: "")
//                .receive(on: environment.mainQueue)
//                .catchToEffect()
//                .map(Action.subscriptionResponse)
//                .cancellable(id: ID(), cancelInFlight: true)
            return .init(value: .subscriptionResponse(.success([])))
        case let .subscriptionResponse(.success(subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case let .subscriptionResponse(.failure(error)):
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
        case fetchMySubscriptions
        case subscriptionResponse(Result<[Subscription_Subscription], Error>)
    }

    struct Environment {
        let mySubscriptionRepository: MySubscriptionsRepository
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }
}
