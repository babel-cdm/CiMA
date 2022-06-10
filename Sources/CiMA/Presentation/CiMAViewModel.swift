//
//  CiMAViewModel.swift
//  
//
//  Created by alvaro.grimal.local on 9/6/22.
//

import Foundation
import Combine
import SwiftUI

// MARK: Protocols

private protocol ViewModelDependencies: AnyObject {
    associatedtype Coordinator
    func getCoordinator() -> Coordinator?
}

protocol LifecycleViewProtocol: AnyObject {
    func onAppear()
    func onDisappear()
}

// MARK: CiMAViewModel

open class CiMAViewModel<Coordinator>: ViewModelDependencies, LifecycleViewProtocol, ObservableObject {
    
    // MARK: Properties
    
    private var cancellableSet = Set<AnyCancellable>()
    private var coordinator: CiMACoordinatorProtocol?

    // MARK: Init
    
    public init(coordinator: CiMACoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    // MARK: ViewModelDependencies protocol
    
    open func getCoordinator() -> Coordinator? {
        return coordinator as? Coordinator
    }
    
    // MARK: LifecycleViewProtocol protocol
    
    open func onAppear() {}
    
    open func onDisappear() {}
}
