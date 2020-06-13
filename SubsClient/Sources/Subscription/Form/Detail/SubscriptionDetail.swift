//
//  SubscriptionDetail.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import Foundation

struct SubscriptionDetail {
    struct State: Equatable {
        var id: String
        var formState: SubscriptionForm.State

        init(subscription: Subscription_Subscription) {
            id = subscription.subscriptionID
            formState = .init(subscription: subscription)
        }
    }

    enum Action {
        case formAction(SubscriptionForm.Action)
        case update
        case updateResponse(Result<Subscription_UpdateSubscriptionResponse, Error>)
        case unregister
        case unregisterResponse(Result<Subscription_UnregisterSubscriptionResponse, Error>)
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
            case .update:
                return environment.subscriptionRepository
                    .updateSubscription(
                        userSubscriptionID: state.id,
                        // TODO set userID
                        userID: "",
                        iconID: state.formState.iconID,
                        serviceName: state.formState.serviceName,
                        price: Int32(state.formState.price),
                        cycle: Int32(state.formState.cycle),
                        // TODO set freeTrial
                        freeTrial: 0,
                        startedAt: state.formState.startedAt)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(Action.updateResponse)
                    .cancellable(id: UpdateID(), cancelInFlight: true)
            case let .updateResponse(.success(response)):
                break
            case let .updateResponse(.failure(e)):
                assertionFailure(e.localizedDescription)
            case .unregister:
                return environment.subscriptionRepository
                    .unregisterSubscription(
                        // TODO set userID
                        userID: "",
                        userSubscriptionID: state.id)
                    .receive(on: environment.mainQueue)
                    .catchToEffect()
                    .map(Action.unregisterResponse)
                    .cancellable(id: DeleteID(), cancelInFlight: true)
            case let .unregisterResponse(.success(response)):
                break
            case let .unregisterResponse(.failure(e)):
                assertionFailure(e.localizedDescription)
            }

            return .none
        }
    )

    struct Environment {
        let subscriptionRepository: SubscriptionRepository
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }

    struct UpdateID: Hashable {}
    struct DeleteID: Hashable {}
}