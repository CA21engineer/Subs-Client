//
//  SubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/13.
//

import ComposableArchitecture
import Core
import Foundation

public struct SubscriptionsRepositoryImpl: SubscriptionServiceRequestable {
    public typealias ResponseType = [Subscription_Subscription]

    public let client: Subscription_SubscriptionServiceClient

    public func fetch() -> Effect<ResponseType, Error> {
        client.getSubscriptions(.init()).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
