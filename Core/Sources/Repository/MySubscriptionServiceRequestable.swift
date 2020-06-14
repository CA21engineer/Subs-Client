//
//  MySubscriptionServiceRequestable.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/13.
//

import ComposableArchitecture
import Foundation
import GRPC
import NIO

public protocol MySubscriptionServiceRequestable {
    associatedtype ResponseType

    var client: Subscription_SubscriptionServiceClient { get }

    func fetch(userID: String) -> Effect<ResponseType, Error>
}

public struct AnyMySubscriptionServiceRequestable<ResponseType>: MySubscriptionServiceRequestable {
    public let client: Subscription_SubscriptionServiceClient = {
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let configuration = ClientConnection.Configuration(
            target: .hostAndPort("35.200.69.138", 8080),
            eventLoopGroup: group
        )
        let connection = ClientConnection(configuration: configuration)
        return Subscription_SubscriptionServiceClient(channel: connection)
    }()

    public init<Inner: MySubscriptionServiceRequestable>(_ inner: Inner) where ResponseType == Inner.ResponseType {
        _request = inner.fetch
    }

    private let _request: (_ userID: String) -> Effect<ResponseType, Error>

    public func fetch(userID: String) -> Effect<ResponseType, Error> {
        _request(userID)
    }
}
