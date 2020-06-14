//
//  SubscriptionServiceRequestable.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import GRPC
import NIO

public protocol SubscriptionServiceRequestable {
    associatedtype ResponseType

    var client: Subscription_SubscriptionServiceClient { get }

    func fetch() -> Effect<ResponseType, Error>
}

public struct AnySubscriptionServiceRequestable<ResponseType>: SubscriptionServiceRequestable {
    public let client: Subscription_SubscriptionServiceClient = {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let configuration = ClientConnection.Configuration(
            target: .hostAndPort("35.200.69.138", 8080),
            eventLoopGroup: group
        )
        let connection = ClientConnection(configuration: configuration)
        return Subscription_SubscriptionServiceClient(channel: connection)
    }()

    public init<Inner: SubscriptionServiceRequestable>(_ inner: Inner) where ResponseType == Inner.ResponseType {
        _request = inner.fetch
    }

    private let _request: () -> Effect<ResponseType, Error>

    public func fetch() -> Effect<ResponseType, Error> {
        _request()
    }
}
