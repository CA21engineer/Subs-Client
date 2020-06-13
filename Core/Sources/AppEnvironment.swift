//
//  AppEnvironment.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Foundation
import GRPC
import NIO

public final class AppEnvironment {
    public let firebaseRepository: FirebaseRepository
    public let iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>
    public let popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
    public let recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>
    public let subscriptionRepository: SubscriptionRepository
    public let subscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
    public let mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_UserSubscription]>
    public let mainQueue: AnySchedulerOf<DispatchQueue>

    public init(
        firebaseRepository: FirebaseRepository,
        iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>,
        popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>,
        recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>,
        subscriptionRepository: SubscriptionRepository,
        mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_UserSubscription]>,
        subscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.firebaseRepository = firebaseRepository
        self.iconImageRepository = iconImageRepository
        self.popularSubscriptionsRepository = popularSubscriptionsRepository
        self.recommendSubscriptionsRepository = recommendSubscriptionsRepository
        self.subscriptionRepository = subscriptionRepository
        self.subscriptionsRepository = subscriptionsRepository
        self.mySubscriptionRepository = mySubscriptionRepository
        self.mainQueue = mainQueue
    }
}
