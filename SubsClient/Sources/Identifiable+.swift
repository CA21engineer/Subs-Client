//
//  Identifiable+.swift
//  Repository
//
//  Created by 伊藤凌也 on 2020/06/08.
//

import ComposableArchitecture

extension Subscription_Subscription: Identifiable {
    public var id: String {
        subscriptionID
    }
}