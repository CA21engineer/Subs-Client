//
//  IconImageRepository.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Core
import GRPC
import NIO

public struct IconImageRepositoryImpl: SubscriptionServiceRequestable {
    public typealias ResponseType = [Subscription_IconImage]

    public let client: Subscription_SubscriptionServiceClient

    public func fetch() -> Effect<ResponseType, Error> {
        client.getIconImageList(.init()).response
            .map { $0.iconImage }
            .receiveEffectWhenComplete()
    }
}
