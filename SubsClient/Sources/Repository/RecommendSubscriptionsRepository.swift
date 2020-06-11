//
//  RecommendSubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture

struct RecommendSubscriptionsRepositoryImpl: SubscriptionServiceRequestable {
    typealias ResponseType = [Subscription_Subscription]

    let client: Subscription_SubscriptionServiceClient

    func fetch() -> Effect<ResponseType, Error> {
        let request = Subscription_GetRecommendSubscriptionsRequest()
        return client.getRecommendSubscriptions(request).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
