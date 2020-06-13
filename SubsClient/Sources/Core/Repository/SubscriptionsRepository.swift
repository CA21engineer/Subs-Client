//
//  SubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/13.
//

import ComposableArchitecture
import Foundation

struct SubscriptionsRepositoryImpl: SubscriptionServiceRequestable {
    typealias ResponseType = [Subscription_Subscription]

    let client: Subscription_SubscriptionServiceClient

    func fetch() -> Effect<ResponseType, Error> {
        client.getSubscriptions(.init()).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
