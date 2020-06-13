//
//  SubscriptionRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Core
import GRPC

public struct SubscriptionRepositoryImpl: SubscriptionRepository {
    public let client: Subscription_SubscriptionServiceClient

    public func createSubscription(
        userID: String,
        serviceName: String,
        iconID: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_CreateSubscriptionResponse, Error> {
        let request = Subscription_CreateSubscriptionRequest.with {
            $0.userID = userID
            $0.serviceName = serviceName
            $0.iconID = iconID
            $0.price = price
            $0.cycle = cycle
            $0.freeTrial = freeTrial
            $0.startedAt = .init(date: startedAt)
        }
        return client.createSubscription(request).response
            .receiveEffectWhenComplete()
    }

    public func registerSubscription(
        userID: String,
        subscriptionID: String,
        price: Int32,
        cycle: Int32,
        startedAt: Date
    ) -> Effect<Subscription_RegisterSubscriptionResponse, Error> {
        let request = Subscription_RegisterSubscriptionRequest.with {
            $0.userID = userID
            $0.subscriptionID = subscriptionID
            $0.price = price
            $0.cycle = cycle
            $0.startedAt = .init(date: startedAt)
        }
        return client.registerSubscription(request).response
            .receiveEffectWhenComplete()
    }

    public func updateSubscription(
        userSubscriptionID: String,
        userID: String,
        iconID: String,
        serviceName: String,
        price: Int32,
        cycle: Int32,
        freeTrial: Int32,
        startedAt: Date
    ) -> Effect<Subscription_UpdateSubscriptionResponse, Error> {
        let request = Subscription_UpdateSubscriptionRequest.with {
            $0.userSubscriptionID = userSubscriptionID
            $0.userID = userID
            $0.iconID = iconID
            $0.serviceName = serviceName
            $0.price = price
            $0.cycle = cycle
            $0.freeTrial = freeTrial
            $0.startedAt = .init(date: startedAt)
        }
        return client.updateSubscription(request).response
            .receiveEffectWhenComplete()
    }

    public func unregisterSubscription(
        userID: String,
        userSubscriptionID: String
    ) -> Effect<Subscription_UnregisterSubscriptionResponse, Error> {
        let request = Subscription_UnregisterSubscriptionRequest.with {
            $0.userSubscriptionID = userSubscriptionID
            $0.userID = userID
        }
        return client.unregisterSubscription(request).response
            .receiveEffectWhenComplete()
    }
}
