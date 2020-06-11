//
//  SubscriptionForm.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import ComposableArchitecture
import Foundation

struct SubscriptionForm {
    private static let yen = "¥"

    struct State: Equatable {
        var imageURL: URL?
        var price: Int = 0
        var serviceName: String = ""
        var cycle: Int = 1
        var startedAt: Date = Date()

        var canSend: Bool {
            isValidToSend(state: self)
        }
    }

    enum Action {
        case changePrice(Int)
        case changeServiceName(String)
        case changeCycle(Int)
        case changeStartedAt(Date)
        case create
        case createFinished(Result<Subscription_CreateSubscriptionResponse, Error>)
    }

    static let reducer = Reducer<State, Action, Environment> { state, action, environment in
        switch action {
        case let .changePrice(price):
            state.price = price
        case let .changeServiceName(serviceName):
            state.serviceName = serviceName
        case let .changeCycle(cycle):
            state.cycle = cycle
        case let .changeStartedAt(startedAt):
            state.startedAt = startedAt
        case .create:
            return environment.subscriptionRepository
                .createSubscription(
                    // TODO: set userID
                    userID: "",
                    serviceName: state.serviceName,
                    // TODO: set iconID
                    iconID: "",
                    price: Int32(state.price),
                    cycle: Int32(state.cycle),
                    // TODO: calculate freeTrial
                    freeTrial: 0,
                    startedAt: state.startedAt
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

    struct Environment {
        let subscriptionRepository: SubscriptionRepository
        let mainQueue: AnySchedulerOf<DispatchQueue>
    }

    struct ID: Hashable {}

    private static func isValidToSend(state: State) -> Bool {
        state.imageURL != nil
            && !state.serviceName.isEmpty
    }
}
