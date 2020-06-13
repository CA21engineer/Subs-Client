//
//  MySubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Core

public struct MySubscriptionsRepositoryImpl: MySubscriptionServiceRequestable {
    public typealias ResponseType = [Subscription_UserSubscription]

    public let client: Subscription_SubscriptionServiceClient

    public func fetch(userID: String) -> Effect<[Subscription_UserSubscription], Error> {
        let request = Subscription_GetMySubscriptionRequest.with {
            $0.userID = userID
        }
        return client.getMySubscription(request).response
            .map { $0.subscriptions }
            .receiveEffectWhenComplete()
    }
}
