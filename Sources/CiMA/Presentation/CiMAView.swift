//
//  CiMAView.swift
//  
//
//  Created by alvaro.grimal.local on 9/6/22.
//

import Foundation
import SwiftUI

// MARK: CiMAView

public struct CiMAView: ViewModifier {

    let viewModel: Any
    
    // For iOS 14.0.1 - 14.4 it should be done in main thread
    @MainActor public func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                guard let viewModel = viewModel as? LifecycleViewProtocol else { return }
                viewModel.onAppear()
            })
            .onDisappear(perform: {
                guard let viewModel = viewModel as? LifecycleViewProtocol else { return }
                viewModel.onDisappear()
            })
    }
}
