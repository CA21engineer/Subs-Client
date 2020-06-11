//
//  MySubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture

protocol MySubscriptionsRepository {
    var client: Subscription_SubscriptionServiceClient { get }

    func fetchMySubscriptions(userID: String) -> Effect<[Subscription_Subscription], Error>
}

struct MySubscriptionsRepositoryImpl: MySubscriptionsRepository {
    let client: Subscription_SubscriptionServiceClient

    func fetchMySubscriptions(userID: String) -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetMySubscriptionRequest.with {
            $0.userID = userID
        }
        return client.getMySubscription(request).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
