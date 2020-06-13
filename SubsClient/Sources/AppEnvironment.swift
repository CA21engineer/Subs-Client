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

final class AppEnvironment {
    let firebaseRepository: FirebaseRepository
    let iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>
    let popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
    let recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>
    let subscriptionRepository: SubscriptionRepository
    let subscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
    let mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>
    let mainQueue: AnySchedulerOf<DispatchQueue>

    init(
        firebaseRepository: FirebaseRepository,
        iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>,
        popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>,
        recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>,
        subscriptionRepository: SubscriptionRepository,
        mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>,
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

    class var shared: AppEnvironment {
        struct Static {
            static let instance: AppEnvironment = {
                let client: Subscription_SubscriptionServiceClient = {
                    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
                    let configuration = ClientConnection.Configuration(
                        target: .hostAndPort("35.221.100.76", 18080),
                        eventLoopGroup: group
                    )
                    let connection = ClientConnection(configuration: configuration)
                    return Subscription_SubscriptionServiceClient(channel: connection)
                }()
                return AppEnvironment(
                    firebaseRepository: FirebaseRepositoryImpl(),
                    iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>(IconImageRepositoryImpl(client: client)),
                    popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>(PopularSubscriptionsRepositoryImpl(client: client)),
                    recommendSubscriptionsRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>(RecommendSubscriptionsRepositoryImpl(client: client)),
                    subscriptionRepository: SubscriptionRepositoryImpl(client: client),
                    mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_Subscription]>(MySubscriptionsRepositoryImpl(client: client)),
                    subscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>(SubscriptionsRepositoryImpl(client: client)),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            }()
        }
        return Static.instance
    }
}
