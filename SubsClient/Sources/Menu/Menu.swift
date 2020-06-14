//
//  Menu.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/14.
//

import ComposableArchitecture
import Core
import Foundation

struct Menu {
    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .fetchRecommendSubscriptions:
            return environment.firebaseRepository.instanceID
                .flatMap {
                    environment.recommendSubscriptionsRepository
                        .fetch(userID: $0)
                }
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.recommendSubscriptionsResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case let .recommendSubscriptionsResponse(.success(subscriptions)):
            state.recommendSubscriptions = subscriptions
            return .none
        case let .recommendSubscriptionsResponse(.failure(error)):
            state.recommendSubscriptions = []
            return .none
        case .fetchPopularSubscriptions:
            return environment.popularSubscriptionsRepository
                .fetch()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.popularSubscriptionsResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case let .popularSubscriptionsResponse(.success(subscriptions)):
            state.popularSubscriptions = subscriptions
            return .none
        case let .popularSubscriptionsResponse(.failure(error)):
            state.popularSubscriptions = []
            return .none
        }
    }.debug()

    struct ID: Hashable {}

    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.recommendSubscriptions == rhs.recommendSubscriptions
        }

        var recommendSubscriptions: [Subscription_Subscription] = []
        var popularSubscriptions: [Subscription_Subscription] = []
    }

    enum Action {
        case fetchRecommendSubscriptions
        case recommendSubscriptionsResponse(Result<[Subscription_Subscription], Error>)
        case fetchPopularSubscriptions
        case popularSubscriptionsResponse(Result<[Subscription_Subscription], Error>)
    }

    struct Environment {
        let firebaseRepository: FirebaseRepository
        let recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>
        let popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }
}
