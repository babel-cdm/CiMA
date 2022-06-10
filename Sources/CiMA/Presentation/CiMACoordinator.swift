//
//  CiMACoordinatorProtocol.swift
//  
//
//  Created by alvaro.grimal.local on 9/6/22.
//

import Foundation
import Combine

// MARK: CiMACoordinatorProtocol

public protocol CiMACoordinatorProtocol {}

// MARK: CiMACoordinator

open class CiMACoordinator: CiMACoordinatorProtocol, ObservableObject, Identifiable {
    public init() {}
}
