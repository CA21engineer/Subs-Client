//
//  HomeTab.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import Foundation

enum HomeTab: CaseIterable {
    case oneMonth
    case threeMonth
    case halfYear
    case oneYear

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

    static func convert(index: Int) -> Self {
        switch index {
        case 0:
            return .oneMonth
        case 1:
            return .threeMonth
        case 2:
            return .halfYear
        case 3:
            return .oneYear
        default:
            fatalError("wrong index")
        }
    }
}
