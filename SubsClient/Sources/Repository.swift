//
//  Repository.swift
//  Repository
//
//  Created by 伊藤凌也 on 2020/06/08.
//

import ComposableArchitecture
import GRPC
import NIO

extension Subscription_Subscription: Identifiable {
    public var id: String {
        subscriptionID
    }
}

public protocol RepositoryProtocol {
    func fetchIconImages() -> Effect<[Subscription_IconImage], Error>
    func fetchMySubscriptions(userID: String) -> Effect<[Subscription_Subscription], Error>
    func fetchSubscriptions() -> Effect<[Subscription_Subscription], Error>
    func createSubscription(
        userID: String,
        serviceName: String,
        iconID: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_CreateSubscriptionResponse, Error>
    func registerSubscription(
        userID: String,
        subscriptionID: String,
        price: Int32,
        cycle: Int32,
        startedAt: Date
    ) -> Effect<Subscription_RegisterSubscriptionResponse, Error>
    func updateSubscripiton(
        userSubscriptionID: String,
        userID: String,
        iconID: String,
        serviceName: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_UpdateSubscriptionResponse, Error>
    func unregisterSubscription(
        userID: String,
        userSubscriptionID: String
    ) -> Effect<Subscription_UnregisterSubscriptionResponse, Error>
}

public struct Repository: RepositoryProtocol {
    private let client: Subscription_SubscriptionServiceClient = {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let configuration = ClientConnection.Configuration(
            target: .hostAndPort("localhost", 18080),
            eventLoopGroup: group
        )
        let connection = ClientConnection(configuration: configuration)
        return Subscription_SubscriptionServiceClient(channel: connection)
    }()

    public init() {}

    public func fetchIconImages() -> Effect<[Subscription_IconImage], Error> {
        do {
            let response = try client.getIconImageList(.init()).response.wait()
            return .init(value: response.iconImage)
        } catch let e {
            return .init(error: e)
        }
    }

    public func fetchMySubscriptions(userID: String) -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetMySubscriptionRequest.with {
            $0.userID = userID
        }
        do {
            let response = try client.getMySubscription(request).response.wait()
            return .init(value: response.subscriptions)
        } catch let e {
            return .init(error: e)
        }
    }

    public func fetchSubscriptions() -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetSubscriptionsRequest()
        do {
            let response = try client.getSubscriptions(request).response.wait()
            return .init(value: response.subscriptions)
        } catch {
            return .init(error: error)
        }
    }

    public func createSubscription(
        userID: String,
        serviceName: String,
        iconID: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_CreateSubscriptionResponse, Error> {
        let request = Subscription_CreateSubscriptionRequest.with {
            $0.userID = userID
            $0.serviceName = serviceName
            $0.iconID = iconID
            $0.price = price
            $0.cycle = cycle
            $0.freeTrial = freeTrial
            $0.startedAt = .init(date: startedAt)
        }

        do {
            let response = try client.createSubscription(request).response.wait()
            return .init(value: response)
        } catch let e {
            return .init(error: e)
        }
    }

    public func registerSubscription(
        userID: String,
        subscriptionID: String,
        price: Int32,
        cycle: Int32,
        startedAt: Date
    ) -> Effect<Subscription_RegisterSubscriptionResponse, Error> {
        let request = Subscription_RegisterSubscriptionRequest.with {
            $0.userID = userID
            $0.subscriptionID = subscriptionID
            $0.price = price
            $0.cycle = cycle
            $0.startedAt = .init(date: startedAt)
        }

        do {
            let respose = try client.registerSubscription(request).response.wait()
            return .init(value: respose)
        } catch let e {
            return .init(error: e)
        }
    }

    public func updateSubscripiton(
        userSubscriptionID: String,
        userID: String,
        iconID: String,
        serviceName: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_UpdateSubscriptionResponse, Error> {
        let request = Subscription_UpdateSubscriptionRequest.with {
            $0.userSubscriptionID = userSubscriptionID
            $0.userID = userID
            $0.iconID = iconID
            $0.serviceName = serviceName
            $0.price = price
            $0.cycle = cycle
            $0.freeTrial = freeTrial
            $0.startedAt = .init(date: startedAt)
        }

        do {
            let response = try client.updateSubscription(request).response.wait()
            return .init(value: response)
        } catch let e {
            return .init(error: e)
        }
    }

    public func unregisterSubscription(
        userID: String,
        userSubscriptionID: String
    ) -> Effect<Subscription_UnregisterSubscriptionResponse, Error> {
        let request = Subscription_UnregisterSubscriptionRequest.with {
            $0.userSubscriptionID = userSubscriptionID
            $0.userID = userID
        }

        do {
            let response = try client.unregisterSubscription(request).response.wait()
            return .init(value: response)
        } catch let e {
            return .init(error: e)
        }
    }
}
