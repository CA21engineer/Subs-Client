//
//  IconImageRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture

struct IconImageRepositoryImpl: SubscriptionServiceRequestable {
    typealias ResponseType = [Subscription_IconImage]

    let client: Subscription_SubscriptionServiceClient

    func fetch() -> Effect<[Subscription_IconImage], Error> {
        do {
            let response = try client.getIconImageList(.init()).response.wait()
            return .init(value: response.iconImage)
        } catch {
            return .init(error: error)
        }
    }
}
