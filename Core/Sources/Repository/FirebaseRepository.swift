//
//  FirebaseRepository.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/13.
//

import ComposableArchitecture

public protocol FirebaseRepository {
    var instanceID: Effect<String, Error> { get }
}
