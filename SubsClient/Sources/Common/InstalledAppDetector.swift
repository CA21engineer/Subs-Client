//
//  InstalledAppDetector.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/13.
//

import Foundation
import UIKit

enum InstalledApp: CaseIterable {
    case awa
    case appleMusic
    case spotify
    case youtubeMusic
    case lineMusic
    case amazonMusicUnlimited
    case youtube
    case abema
    case netflix
    case amazonPrimeVideo
    case hulu
    case openRec
    case dAnime
    case fod
    case tapple
    case crossMe
    case tinder
    case with
    case iCloud
    case googleCloud

    var serviceId: String { // server側が持ってるuid
        switch self {
        case .awa:
            return "1"
        case .appleMusic:
            return "2"
        case .spotify:
            return "3"
        case .youtubeMusic:
            return "4"
        case .lineMusic:
            return "5"
        case .amazonMusicUnlimited:
            return "6"
        case .youtube:
            return "7"
        case .abema:
            return "8"
        case .netflix:
            return "9"
        case .amazonPrimeVideo:
            return "10"
        case .hulu:
            return "11"
        case .openRec:
            return "12"
        case .dAnime:
            return "13"
        case .fod:
            return "14"
        case .tapple:
            return "15"
        case .crossMe:
            return "16"
        case .tinder:
            return "17"
        case .with:
            return "18"
        case .iCloud:
            return "19"
        case .googleCloud:
            return "20"
        }
    }

    var deeplink: String {
        switch self {
        case .awa:
            return "fmawa://settings/activation?code=ehkovdr"
        case .appleMusic:
            return "music://album"
        case .spotify:
            return "spotify://home"
        case .youtubeMusic:
            return "youtube://"
        case .lineMusic:
            return ""
        case .amazonMusicUnlimited:
            return ""
        case .youtube:
            return ""
        case .abema:
            return ""
        case .netflix:
            return ""
        case .amazonPrimeVideo:
            return ""
        case .hulu:
            return ""
        case .openRec:
            return ""
        case .dAnime:
            return ""
        case .fod:
            return ""
        case .tapple:
            return ""
        case .crossMe:
            return ""
        case .tinder:
            return ""
        case .with:
            return ""
        case .iCloud:
            return ""
        case .googleCloud:
            return ""
        }
    }
}

final class InstalledAppDetector {
    private let apps = InstalledApp.allCases

    func detect() -> [InstalledApp] {
        // インストールされていた場合のみ値を返す
        apps.compactMap { app -> InstalledApp? in
            if let url = URL(string: app.deeplink), UIApplication.shared.canOpenURL(url) {
                return app
            } else {
                return nil
            }
        }
    }
}
