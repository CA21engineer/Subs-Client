//
//  RecommendSubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Core

public struct RecommendSubscriptionsRepositoryImpl: MySubscriptionServiceRequestable {
    public typealias ResponseType = [Subscription_Subscription]

    public let client: Subscription_SubscriptionServiceClient

    public func fetch(userID: String) -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetRecommendSubscriptionsRequest.with {
            $0.userID = userID
        }
        return client.getRecommendSubscriptions(request).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
