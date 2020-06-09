//
//  AppEnvironment.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import Foundation
import ComposableArchitecture

struct AppEnvironment {
    let repository: Repository
    let mainQueue: AnySchedulerOf<DispatchQueue>
}
