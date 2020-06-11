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
    }

    enum Action {
        case changePrice(Int)
        case changeServiceName(String)
        case changeCycle(Int)
        case changeStartedAt(Date)
    }

    static let reducer = Reducer<State, Action, AppEnvironment> { state, action, environment in
        switch action {
        case let .changePrice(price):
            state.price = price
        case let .changeServiceName(serviceName):
            state.serviceName = serviceName
        case let .changeCycle(cycle):
            state.cycle = cycle
        case let .changeStartedAt(startedAt):
            state.startedAt = startedAt
        }
        return .none
    }
}
