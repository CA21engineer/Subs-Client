//
//  RecommendSubscriptionList.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Core
import Foundation

struct RecommendSubscriptionList {
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

    struct Environment {
        let firebaseRepository: FirebaseRepository
        let recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }
}
