//
//  BaseViewModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import CiMA
import Combine

class BaseViewModel<Coordinator>: CiMAViewModel<Coordinator> {
    internal var subscriptions = [AnyCancellable]()
}
