//
//  FirebaseRepository.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture
import Firebase

protocol FirebaseRepository {
    var instanceID: Effect<String, Error> { get }
}

struct FirebaseRepositoryImpl: FirebaseRepository {
    var instanceID: Effect<String, Error> {
        Effect<String, Error>.future { (callback) in
            InstanceID.instanceID().instanceID { (result, error) in
                switch (result, error) {
                case (.some(let result), .none):
                    callback(.success(result.instanceID))
                case (.none, .some(let e)):
                    callback(.failure(e))
                case (.some, .some), (.none, .none):
                    assertionFailure()
                }
            }
        }
    }
}
