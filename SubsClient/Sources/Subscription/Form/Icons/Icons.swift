//
//  Icons.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/12.
//

import ComposableArchitecture
import Foundation

struct Icons {
    struct State: Equatable {
        var icons: [Subscription_IconImage] = []
    }

    enum Action {
        case load
        case iconImageResponse(Result<[Subscription_IconImage], Error>)
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case .load:
            return environment.iconImageRepository
                .fetch()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(Action.iconImageResponse)
                .cancellable(id: ID(), cancelInFlight: true)
        case let .iconImageResponse(.success(iconImages)):
            state.icons = iconImages
        case let .iconImageResponse(.failure(e)):
            // do something
            break
        }

        return .none
    }

    struct Environment {
        let iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }

    struct ID: Hashable {}
}

