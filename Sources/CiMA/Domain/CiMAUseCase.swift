//
//  CiMAUseCase.swift
//  
//
//  Created by alvaro.grimal.local on 23/6/22.
//

import Foundation

open class CiMAUseCase<Input, Output, Process> {
    
    // MARK: - Properties
    private var onCompletionStopped: (() -> Void)?
    
    /**
     Thread where the `handle(_:_:_:_:)` function will be executed.
     This variable can be overridden to change the dispatch queue.
     By default, the dispatchQueue is 'DispatchQueue.global(qos: .background)'
     */
    open var dispatchQueue: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    // MARK: - Functions
    
    /**
     Main method of executing the interactor.
     This method executes the `handle(_:_:_:_:)` method on the thread that has been indicated in the `dispatchQueue` variable.
     
     - Parameters:
     - parameter: The only parameter where it will have all the necessary properties to execute the interactor.
     - onSuccess: Called when the interactor has been successfully completed.
     - onFailure: Called in when the interactor has mistakenly ended.
     - onProcess: It is only called if the `handle(_:_:_:_:)` method is used, passing it to some process to know the progress. For example in an image upload.
     - onStopped: Called when the interactor has stopped calling the `dispose(_:)`, or has been released from memory.
     
     - Returns: Disposable object in case the programmer wants to release the interactor before the end of the use case.
     */
    public func execute(_ parameter: Input? = nil,
                        onSuccess: ((Output) -> Void)? = nil,
                        onFailure: ((Error) -> Void)? = nil,
                        onProcess: ((Process) -> Void)? = nil) {
        dispatchQueue.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            if let parameter = parameter, Input.self != Void.self {
                strongSelf.handle(parameter: parameter,
                                  onSuccess: onSuccess ?? { _ in },
                                  onFailure: onFailure ?? { _ in },
                                  onProcess: onProcess ?? { _ in })
            } else {
                strongSelf.handle(onSuccess: onSuccess ?? { _ in },
                                  onFailure: onFailure ?? { _ in },
                                  onProcess: onProcess ?? { _ in })
            }
        }
    }
    
    private func getVoidCompletion<T>(_ onCompletion: @escaping (T) -> Void) -> (() -> Void)? {
        if let onVoidCompletion = onCompletion as? ((()) -> Void) {
            return { onVoidCompletion(()) }
        }
        return nil
    }
    
    /**
     This function must be overridden to add code that we want to execute the use case in the thread indicated in the `dispatchQueue` variable.
     Use this function when the Interactor has an Input and an Output other than 'Void'.
     
     - Parameters:
     - parameter: Input parameter entered in the `execute(_:_:_:_:_:)` method.
     - onSuccess: Success completion handler with Output object.
     - onFailure: Failure completion handler with Error object.
     - onProcess: Process completion handler with Process object.
     */
    open func handle(parameter: Input,
                     onSuccess: @escaping (Output) -> Void,
                     onFailure: @escaping (Error) -> Void,
                     onProcess: @escaping (Process) -> Void) {
        if let onSuccessCompletion = getVoidCompletion(onSuccess) {
            handle(parameter: parameter, onSuccess: onSuccessCompletion, onFailure: onFailure, onProcess: onProcess)
        }
    }
    
    /**
     This function must be overridden to add code that we want to execute the use case in the thread indicated in the `dispatchQueue` variable.
     Use this function when the Interactor has Output object only other than 'Void'.
     
     - Parameters:
     - onSuccess: Success completion handler with Output object.
     - onFailure: Failure completion handler with Error object.
     - onProcess: Process completion handler with Process object.
     */
    open func handle(onSuccess: @escaping (Output) -> Void,
                     onFailure: @escaping (Error) -> Void,
                     onProcess: @escaping (Process) -> Void) {
        if let onSuccessCompletion = getVoidCompletion(onSuccess) {
            handle(onSuccess: onSuccessCompletion, onFailure: onFailure, onProcess: onProcess)
        }
    }
    
    /**
     This function must be overridden to add code that we want to execute the use case in the thread indicated in the `dispatchQueue` variable.
     Use this function when the Interactor has an Input other than 'Void', but the Output is 'Void' type.
     
     - Parameters:
     - parameter: Success completion handler with Output object.
     - onSuccess: Success completion handler without object.
     - onFailure: Failure completion handler with Error object.
     - onProcess: Process completion handler with Process object.
     */
    open func handle(parameter: Input,
                     onSuccess: @escaping () -> Void,
                     onFailure: @escaping (Error) -> Void,
                     onProcess: @escaping (Process) -> Void) {}
    
    /**
     This function must be overridden to add code that we want to execute the use case in the thread indicated in the `dispatchQueue` variable.
     Use this function when the Interactor has neither Input nor Output. That is, both are 'Void' type.
     
     - Parameters:
     - onSuccess: Success completion handler without object.
     - onFailure: Failure completion handler with Error object.
     - onProcess: Process completion handler with Process object.
     */
    open func handle(onSuccess: @escaping () -> Void,
                     onFailure: @escaping (Error) -> Void,
                     onProcess: @escaping (Process) -> Void) {}
}

