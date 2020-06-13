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
    let recommendSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>
    let subscriptionRepository: SubscriptionRepository
    let mySubscriptionRepository: MySubscriptionsRepository
    let mainQueue: AnySchedulerOf<DispatchQueue>

    init(
        firebaseRepository: FirebaseRepository,
        iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>,
        popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>,
        recommendSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>,
        subscriptionRepository: SubscriptionRepository,
        mySubscriptionRepository: MySubscriptionsRepository,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.firebaseRepository = firebaseRepository
        self.iconImageRepository = iconImageRepository
        self.popularSubscriptionsRepository = popularSubscriptionsRepository
        self.recommendSubscriptionsRepository = recommendSubscriptionsRepository
        self.subscriptionRepository = subscriptionRepository
        self.mySubscriptionRepository = mySubscriptionRepository
        self.mainQueue = mainQueue
    }

    class var shared: AppEnvironment {
        struct Static {
            static let instance: AppEnvironment = {
                let client: Subscription_SubscriptionServiceClient = {
                    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
                    let configuration = ClientConnection.Configuration(
                        target: .hostAndPort("localhost", 18080),
                        eventLoopGroup: group
                    )
                    let connection = ClientConnection(configuration: configuration)
                    return Subscription_SubscriptionServiceClient(channel: connection)
                }()
                return AppEnvironment(
                    firebaseRepository: FirebaseRepositoryImpl(),
                    iconImageRepository: AnySubscriptionServiceRequestable<[Subscription_IconImage]>(IconImageRepositoryImpl(client: client)),
                    popularSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>(PopularSubscriptionsRepositoryImpl(client: client)),
                    recommendSubscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>(RecommendSubscriptionsRepositoryImpl(client: client)),
                    subscriptionRepository: SubscriptionRepositoryImpl(client: client),
                    mySubscriptionRepository: MySubscriptionsRepositoryImpl(client: client),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            }()
        }
        return Static.instance
    }
}
