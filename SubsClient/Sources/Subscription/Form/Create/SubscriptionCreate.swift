//
//  SubscriptionCreateForm.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import Foundation

struct SubscriptionCreate {
    struct State: Equatable {
        var formState: SubscriptionForm.State

        init() {
            formState = .init()
        }

        init(subscription: Subscription_Subscription) {
            formState = .init(subscription: subscription)
        }
    }

    enum Action {
        case formAction(SubscriptionForm.Action)
        case create
        case createFinished(Result<Subscription_CreateSubscriptionResponse, Error>)
        case registerFinished(Result<Subscription_RegisterSubscriptionResponse, Error>)
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        SubscriptionForm.reducer.pullback(
            state: \.formState,
            action: /Action.formAction,
            environment: { _ in
                SubscriptionForm.Environment()
            }
        ),
        Reducer { state, action, environment in
            switch action {
            case .formAction:
                return .none
            case .create:
                if state.formState.isOriginal {
                    return environment.firebaseRepository.instanceID
                        .flatMap { [state] in
                            environment.subscriptionRepository
                                .registerSubscription(
                                    userID: $0,
                                    subscriptionID: state.formState.subscriptionID,
                                    price: Int32(state.formState.price),
                                    cycle: Int32(state.formState.cycle),
                                    // TODO: calculate freeTrial
                                    startedAt: state.formState.startedAt
                                )
                        }
                        .catchToEffect()
                        .map(Action.registerFinished)
                        .cancellable(id: ID(), cancelInFlight: true)
                } else {
                    return environment.firebaseRepository.instanceID
                        .flatMap { [state] in
                            environment.subscriptionRepository
                                .createSubscription(
                                    userID: $0,
                                    serviceName: state.formState.serviceName,
                                    iconID: state.formState.iconID,
                                    price: Int32(state.formState.price),
                                    cycle: Int32(state.formState.cycle),
                                    // TODO: calculate freeTrial
                                    freeTrial: 0,
                                    startedAt: state.formState.startedAt
                                )
                        }
                        .catchToEffect()
                        .map(Action.createFinished)
                        .cancellable(id: ID(), cancelInFlight: true)
                }
            case let .createFinished(.success(response)):
                // do something
                break
            case let .createFinished(.failure(e)):
                // do something
                break
            case let .registerFinished(.success(response)):
                // do something
                break
            case let .registerFinished(.failure(e)):
                // do something
                break
            }

            return .none
        }
    )

    struct Environment {
        let subscriptionRepository: SubscriptionRepository
        let firebaseRepository: FirebaseRepository
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }

    struct ID: Hashable {}
}
