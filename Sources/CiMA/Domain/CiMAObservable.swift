//
//  CiMAObservable.swift
//  
//
//  Created by alvaro.grimal.local on 23/6/22.
//

import Foundation
import Combine

public typealias CiMAObservable<T> = AnyPublisher<T, Error>

extension Publisher {
    public func asObservable() -> CiMAObservable<Output> {
        mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    public static func just(_ output: Output) -> CiMAObservable<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public static func empty() -> CiMAObservable<Output> {
        Empty()
            .eraseToAnyPublisher()
    }

    public static func failure(_ error: Error) -> CiMAObservable<Output> {
        Fail<Output, Error>(error: error)
            .eraseToAnyPublisher()
    }

    public func sink() -> AnyCancellable {
        sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}
