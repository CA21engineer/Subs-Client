//
//  OnBoarding.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/10.
//

import ComposableArchitecture
import Core
import Foundation

struct OnBoarding {
    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .fetchSubscriptions:
            return environment.subscriptionsRepository
                .fetch()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.subscriptionsResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case let .subscriptionsResponse(.success(subscriptions)):
            let installedAppIds = InstalledAppDetector.detect().map { $0.serviceId }
            state.subscriptions = subscriptions.compactMap { subscription -> Subscription_Subscription? in
                installedAppIds.contains(subscription.id) ? subscription : nil
            }
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

    struct Environment {
        let subscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }
}
