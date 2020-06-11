//
//  PopularSubscriptionsRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture

struct PopularSubscriptionsRepositoryImpl: SubscriptionServiceRequestable {
    typealias ResponseType = [Subscription_Subscription]

    let client: Subscription_SubscriptionServiceClient

    func fetch() -> Effect<[Subscription_Subscription], Error> {
        let request = Subscription_GetSubscriptionsRequest()
        do {
            let response = try client.getSubscriptions(request).response.wait()
            return .init(value: response.subscriptions)
        } catch {
            return .init(error: error)
        }
    }
}
