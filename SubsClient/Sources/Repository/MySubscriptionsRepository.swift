//
//  MySubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture

struct MySubscriptionsRepositoryImpl: MySubscriptionServiceRequestable {
    typealias ResponseType = [Subscription_UserSubscription]

    let client: Subscription_SubscriptionServiceClient

    func fetch(userID: String) -> Effect<[Subscription_UserSubscription], Error> {
        let request = Subscription_GetMySubscriptionRequest.with {
            $0.userID = userID
        }
        return client.getMySubscription(request).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
