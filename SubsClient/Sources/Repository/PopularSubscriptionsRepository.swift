//
//  PopularSubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Core

public struct PopularSubscriptionsRepositoryImpl: SubscriptionServiceRequestable {
    public typealias ResponseType = [Subscription_Subscription]

    public let client: Subscription_SubscriptionServiceClient

    public func fetch() -> Effect<ResponseType, Error> {
        client.getPopularSubscriptions(.init()).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
