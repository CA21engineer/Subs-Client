//
//  MySubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Foundation
import GRPC
import NIO

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
        do {
            let response = try client.getMySubscription(request).response.wait()
            return .init(value: response.subscriptions)
        } catch let e {
            return .init(error: e)
        }
    }
}
