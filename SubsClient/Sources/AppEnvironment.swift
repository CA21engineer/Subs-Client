//
//  AppEnvironment.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/09.
//

import ComposableArchitecture
import Foundation

final class AppEnvironment {
    let repository: Repository
    let mainQueue: AnySchedulerOf<DispatchQueue>

    init(repository: Repository, mainQueue: AnySchedulerOf<DispatchQueue>) {
        self.repository = repository
        self.mainQueue = mainQueue
    }

    class var shared: AppEnvironment {
        struct Static {
            static let instance = AppEnvironment(
                repository: Repository(),
                mainQueue: DispatchQueue.main.eraseToAnyScheduler()
            )
        }
        return Static.instance
    }
}
