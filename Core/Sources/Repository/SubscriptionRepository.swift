//
//  SubscriptionRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import GRPC

public protocol SubscriptionRepository {
    var client: Subscription_SubscriptionServiceClient { get }

    func createSubscription(
        userID: String,
        serviceName: String,
        iconID: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_CreateSubscriptionResponse, Error>
    func registerSubscription(
        userID: String,
        subscriptionID: String,
        price: Int32,
        cycle: Int32,
        startedAt: Date
    ) -> Effect<Subscription_RegisterSubscriptionResponse, Error>
    func updateSubscription(
        userSubscriptionID: String,
        userID: String,
        iconID: String,
        serviceName: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_UpdateSubscriptionResponse, Error>
    func unregisterSubscription(
        userID: String,
        userSubscriptionID: String
    ) -> Effect<Subscription_UnregisterSubscriptionResponse, Error>
}
