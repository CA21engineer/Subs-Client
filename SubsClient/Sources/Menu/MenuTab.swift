//
//  MenuTab.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/08.
//

import Foundation

enum MenuTab: Int, CaseIterable {
    case forYou
    case popular

    var title: String {
        switch self {
        case .forYou:
            return "For You"
        case .popular:
            return "人気"
        }
    }
}
