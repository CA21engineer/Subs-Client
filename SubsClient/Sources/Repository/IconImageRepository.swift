//
//  IconImageRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import GRPC
import NIO

struct IconImageRepositoryImpl: SubscriptionServiceRequestable {
    typealias ResponseType = [Subscription_IconImage]

    let client: Subscription_SubscriptionServiceClient

    func fetch() -> Effect<ResponseType, Error> {
        client.getIconImageList(.init()).response
            .map { $0.iconImage }
            .receiveEffectWhenComplete()
    }
}
