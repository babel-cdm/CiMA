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
    var coordinator: Coordinator { get }
}

protocol LifecycleViewProtocol: AnyObject {
    func onAppear()
    func onDisappear()
    func onLoad()
}

open class CiMALoadable: ObservableObject {
    @Published var isLoading: Bool = false
}

// MARK: CiMAViewModel

open class CiMAViewModel<Coordinator>: CiMALoadable, ViewModelDependencies, LifecycleViewProtocol {

    // MARK: Properties
    
    open var cancellableSet = Set<AnyCancellable>()
    private var isLoadingCount = Int.zero
    private var cimaCoordinator: CiMACoordinatorProtocol?

    // MARK: Init
    
    public init(coordinator: CiMACoordinatorProtocol) {
        self.cimaCoordinator = coordinator
        super.init()
    }
    
    // MARK: ViewModelDependencies protocol
    
    public var coordinator: Coordinator? {
        cimaCoordinator as? Coordinator
    }

    // MARK: LifecycleViewProtocol protocol
    
    open func onAppear() {}
    
    open func onDisappear() {}
    
    open func onLoad() {}
    
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
