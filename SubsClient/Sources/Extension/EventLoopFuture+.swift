//
//  EventLoopFuture+.swift
//  SubsClient
//
//  Created by 長田卓馬 on 2020/06/11.
//

import ComposableArchitecture
import Foundation
import NIO

extension EventLoopFuture {
    func receiveEffectWhenComplete() -> Effect<Value, Error> {
        Effect<Value, Error>.future { callback in
            self.whenComplete { result in
                switch result {
                case let .success(response):
                    callback(.success(response))
                case let .failure(error):
                    callback(.failure(error))
                }
            }
        }
    }
}
