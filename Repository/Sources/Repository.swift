//
//  Repository.swift
//  Repository
//
//  Created by 伊藤凌也 on 2020/06/08.
//

import ComposableArchitecture
import GRPC
import NIO

public protocol RepositoryProtocol {
    func fetchIconImages() -> Effect<[Subscription_IconImage], Error>
    func fetchMySubscriptions(accountID: String) -> Effect<[Subscription_Subscription], Error>
    func fetchSubscriptions() -> Effect<[Subscription_Subscription], Error>
    func createSubscription(
        accountID: String,
        subscriptionName: String,
        iconID: String,
        price: Int32,
        cycle: Int32
    ) -> Effect<Void, Error>
    func registerSubscription(
        accountID: String,
        price: Int32,
        cycle: Int32
    ) -> Effect<Void, Error>
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

    public func fetchMySubscriptions(accountID: String) -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetMySubscriptionRequest.with {
            $0.accountID = accountID
        }
        do {
            let response = try client.getMySubscription(request).response.wait()
            return .init(value: response.subscriptions)
        } catch let e {
            return .init(error: e)
        }
    }

    public func fetchSubscriptions() -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetSubscriptionRequest()
        do {
            let response = try client.getSubscription(request).response.wait()
            return .init(value: response.subscriptions)
        } catch {
            return .init(error: error)
        }
    }

    public func createSubscription(
        accountID: String,
        subscriptionName: String,
        iconID: String,
        price: Int32,
        cycle: Int32
    ) -> Effect<Void, Error> {
        let request = Subscription_CreateSubscriptionRequest.with {
            $0.accountID = accountID
            $0.subscriptionName = subscriptionName
            $0.iconID = iconID
            $0.price = price
            $0.cycle = cycle
        }

        do {
            let _ = try client.createSubscription(request).response.wait()
            return .init(value: ())
        } catch let e {
            return .init(error: e)
        }
    }

    public func registerSubscription(
        accountID: String,
        price: Int32,
        cycle: Int32
    ) -> Effect<Void, Error> {
        let request = Subscription_RegisterSubscriptionRequest.with {
            $0.accountID = accountID
            $0.price = price
            $0.cycle = cycle
        }

        do {
            let _ = try client.registerSubscription(request).response.wait()
            return .init(value: ())
        } catch let e {
            return .init(error: e)
        }
    }
}
