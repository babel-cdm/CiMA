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

open class CiMALoadable: ObservableObject {
    @Published var isLoading: Bool = false
}

// MARK: CiMAViewModel

open class CiMAViewModel<Coordinator>: CiMALoadable, ViewModelDependencies, LifecycleViewProtocol {

    // MARK: Properties
    
    open var cancellableSet = Set<AnyCancellable>()
    private var isLoadingCount = Int.zero
    private var coordinator: CiMACoordinatorProtocol?
    
    // MARK: Init
    
    public init(coordinator: CiMACoordinatorProtocol) {
        self.coordinator = coordinator
        super.init()
    }
    
    // MARK: ViewModelDependencies protocol
    
    open func getCoordinator() -> Coordinator? {
        return coordinator as? Coordinator
    }
    
    // MARK: LifecycleViewProtocol protocol
    
    open func onAppear() {}
    
    open func onDisappear() {}
    
    // MARK: - Loading view
    
    public func showLoading() {
        handleLoading(+=)
    }
    
    public func hideLoading() {
        handleLoading(-=)
    }
    
    private func handleLoading(_ operation: ((_ lhs: inout Int, _ rhs: Int) -> Void)) {
        operation(&isLoadingCount, 1)
        isLoading = isLoadingCount > .zero
    }
}
