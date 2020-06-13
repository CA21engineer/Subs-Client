//
//  AppEnvironment+Ex.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/14.
//

import Core
import GRPC
import NIO

extension AppEnvironment {
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
                    mySubscriptionRepository: AnyMySubscriptionServiceRequestable<[Subscription_UserSubscription]>(MySubscriptionsRepositoryImpl(client: client)),
                    subscriptionsRepository: AnySubscriptionServiceRequestable<[Subscription_Subscription]>(SubscriptionsRepositoryImpl(client: client)),
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            }()
        }
        return Static.instance
    }
}
