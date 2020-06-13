//
//  Subscription_ServiceType+.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/13.
//

import Foundation

public extension Subscription_ServiceType {
    var title: String {
        switch self {
        case .notFound:
            return ""
        case .notCategorized:
            return "その他"
        case .music:
            return "ミュージック"
        case .movie:
            return "動画・ライブ配信"
        case .matching:
            return "マッチングアプリ"
        case .storage:
            return "ビジネス・ツール"
        case .UNRECOGNIZED:
            return ""
        }
    }
}
