//
//  Home.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Foundation

struct Home {
    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .fetchMySubscriptions:
            return environment.firebaseRepository.instanceID
                .flatMap {
                    environment.mySubscriptionRepository
                        .fetch(userID: $0)
                }
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.subscriptionResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case let .subscriptionResponse(.success(subscriptions)):
            state.subscriptions = subscriptions
            return .none
        case let .subscriptionResponse(.failure(error)):
            state.subscriptions = []
            return .none
        }
    }

    struct ID: Hashable {}

    struct State: Equatable {
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.subscriptions == rhs.subscriptions
        }

        var subscriptions: [Subscription_UserSubscription] = []
    }

    enum Action {
        case fetchMySubscriptions
        case subscriptionResponse(Result<[Subscription_UserSubscription], Error>)
    }

    struct Environment {
        let firebaseRepository: FirebaseRepository
        let mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_UserSubscription]>
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }
}
