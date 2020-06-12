//
//  HomeTab.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import Foundation

enum HomeTab: Int, CaseIterable {
    case oneMonth = 0
    case threeMonth = 1
    case halfYear = 2
    case oneYear = 3

    var title: String {
        switch self {
        case .oneMonth:
            return "1ヶ月"
        case .threeMonth:
            return "3ヶ月"
        case .halfYear:
            return "半年"
        case .oneYear:
            return "1年"
        }
    }

    var headerTitle: String {
        switch self {
        case .oneMonth:
            return "月"
        case .threeMonth:
            return "3ヶ月"
        case .halfYear:
            return "半年"
        case .oneYear:
            return "年"
        }
    }

    var monthCount: Int {
        switch self {
        case .oneMonth:
            return 1
        case .threeMonth:
            return 3
        case .halfYear:
            return 6
        case .oneYear:
            return 12
        }
    }
}
