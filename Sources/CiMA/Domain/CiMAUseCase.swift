//
//  CiMAUseCase.swift
//  
//
//  Created by alvaro.grimal.local on 23/6/22.
//

import Foundation
import Combine

open class CiMAUseCase<Input, Output> {
    
    // MARK: - Properties
    
    /**
     Thread where the `handle(_:) -> CiMAObservable<Output>` function will receive elements from the publisher.
     This variable can be overridden to change the dispatch queue.
     By default, the dispatchQueue is 'DispatchQueue.main'
     */
    open var receiveDispatchQueue: DispatchQueue {
        return DispatchQueue.main
    }
    
    /**
     Thread where the `handle(_:) -> CiMAObservable<Output>` function will be executed.
     This variable can be overridden to change the dispatch queue.
     By default, the dispatchQueue is 'DispatchQueue.global(qos: .background)'
     */
    open var subscribeDispatchQueue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    // MARK: - Functions
    
    public init() {}
    
    /**
     Main method of executing the useCase.
     This method executes the `handle(_:) -> CiMAObservable<Output>` method on the thread that has been indicated in the `subscribeDispatchQueue` variable.
     
     - Parameters:
     - input: The only parameter where it will have all the necessary properties to execute the useCase.
     
     - Returns: It returns an object of type `CiMAObservable<Output>`.
     */
    public func execute(_ input: Input? = nil) -> CiMAObservable<Output> {
        guard let handle = handle(input: input) else {
            return Fail(error: NSError(domain: "CiMAUseCase handle function failed", code: -10001, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return handle
            .subscribe(on: subscribeDispatchQueue)
            .receive(on: receiveDispatchQueue)
            .asObservable()
            .eraseToAnyPublisher()
    }
    
    /**
     Main method of executing the useCase.
     This method executes the `handle(input: Input) async throws -> Output` which use async/await.
     
     - Parameters:
     - input: The only parameter where it will have all the necessary properties to execute the useCase.
     
     - Returns: It returns an object of type `Output`.
     */
    public func execute(_ input: Input) async throws -> Output {
        try await handle(input: input)
    }
    
    /**
     This function must be overridden to add code that we want to execute the use case in the thread indicated in the `subscribeDispatchQueue` variable.
     
     - Parameters:
     - input: The only parameter where it will have all the necessary properties to execute the useCase.
     
     - Returns: It returns an object of type `CiMAObservable<Output>`.
     */
    open func handle(input: Input? = nil) -> CiMAObservable<Output>? { nil }

    /**
     This function must be overridden to add code that we want to execute the use case with async/await.
     
     - Parameters:
     - input: The only parameter where it will have all the necessary properties to execute the useCase.
     
     - Returns: It returns an object of type `Output`.
     */
    open func handle(input: Input) async throws -> Output {
        throw NSError(domain: "Not implemented. Override it in subclass.", code: -1000)
    }
}

extension CiMAUseCase where Input == Void {
    /**
     Main method of executing the useCase.
     This method executes the `handle() async throws -> Output` which use async/await.
     
     - Returns: It returns an object of type `Output`.
     */
    public func execute() async throws -> Output {
        try await handle(input: ())
    }
}
