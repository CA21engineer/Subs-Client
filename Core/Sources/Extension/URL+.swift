//
//  URL+.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/12.
//

import Foundation

public extension Subscription_IconImage {
    var url: URL? {
        URL(string: iconUri)
    }
}

extension Subscription_IconImage: Equatable {}

public extension Subscription_Subscription {
    var url: URL? {
        URL(string: iconUri)
    }
}

extension Subscription_Subscription: Equatable {}
