//
//  SubscriptionRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Foundation
import GRPC
import NIO

protocol SubscriptionRepository {
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

struct SubscriptionRepositoryImpl: SubscriptionRepository {
    let client: Subscription_SubscriptionServiceClient

    func createSubscription(
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

        do {
            let response = try client.createSubscription(request).response.wait()
            return .init(value: response)
        } catch let e {
            return .init(error: e)
        }
    }

    func registerSubscription(
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

        do {
            let respose = try client.registerSubscription(request).response.wait()
            return .init(value: respose)
        } catch let e {
            return .init(error: e)
        }
    }

    func updateSubscription(
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

        do {
            let response = try client.updateSubscription(request).response.wait()
            return .init(value: response)
        } catch let e {
            return .init(error: e)
        }
    }

    func unregisterSubscription(
        userID: String,
        userSubscriptionID: String
    ) -> Effect<Subscription_UnregisterSubscriptionResponse, Error> {
        let request = Subscription_UnregisterSubscriptionRequest.with {
            $0.userSubscriptionID = userSubscriptionID
            $0.userID = userID
        }

        do {
            let response = try client.unregisterSubscription(request).response.wait()
            return .init(value: response)
        } catch let e {
            return .init(error: e)
        }
    }
}
