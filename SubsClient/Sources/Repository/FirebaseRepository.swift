//
//  FirebaseRepository.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import Core
import Firebase

public struct FirebaseRepositoryImpl: FirebaseRepository {
    public var instanceID: Effect<String, Error> {
        Effect<String, Error>.future { callback in
            InstanceID.instanceID().instanceID { result, error in
                switch (result, error) {
                case let (.some(result), .none):
                    callback(.success(result.token))
                case let (.none, .some(e)):
                    callback(.failure(e))
                case (.some, .some), (.none, .none):
                    assertionFailure()
                }
            }
        }
    }
}
