//
//  SubscriptionCreateForm.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import Foundation

struct SubscriptionCreateForm {
    struct State: Equatable {
        var formState: SubscriptionForm.State
    }

    enum Action {
        case formAction(SubscriptionForm.Action)
        case create
        case createFinished(Result<Subscription_CreateSubscriptionResponse, Error>)
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        SubscriptionForm.reducer.pullback(
            state: \.formState,
            action: /Action.formAction,
            environment: {_ in
                SubscriptionForm.Environment()
            }
        ),
        Reducer { state, action, environment in
            switch action {
            case .formAction:
                return .none
            case .create:
                return environment.subscriptionRepository
                    .createSubscription(
                        // TODO: set userID
                        userID: "",
                        serviceName: state.formState.serviceName,
                        iconID: state.formState.iconID,
                        price: Int32(state.formState.price),
                        cycle: Int32(state.formState.cycle),
                        // TODO: calculate freeTrial
                        freeTrial: 0,
                        startedAt: state.formState.startedAt
                    )
                    .catchToEffect()
                    .map(Action.createFinished)
                    .cancellable(id: ID(), cancelInFlight: true)
            case let .createFinished(.success(response)):
                // do something
                break
            case let .createFinished(.failure(e)):
                // do something
                break
            }

            return .none
        }
    )

    struct Environment {
        let subscriptionRepository: SubscriptionRepository
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }

    struct ID: Hashable {}
}
