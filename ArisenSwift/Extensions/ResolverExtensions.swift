//
//  ResolverExtensions.swift
//  ArisenSwift
//
//  Created by Steve McCoole on 4/18/19.
//  Copyright (c) 2017-2019 block.one and its contributors. All rights reserved.
//

import Foundation
import PromiseKit

public extension Resolver {

    /// A PromiseKit Resolver for resolving promises with an `ArisenResult`.
    /// Useful for wrapping (with promises) methods that take callbacks that get called with an `ArisenResult`.
    ///
    /// - Parameter result: The `ArisenResult`.
    func resolve(_ result: ArisenResult<T, ArisenError>) {
        switch result {
        case .failure (let err):
            reject(err)
        case .success (let res):
            fulfill(res)
        }
    }
}
