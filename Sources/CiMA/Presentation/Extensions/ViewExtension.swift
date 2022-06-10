//
//  ViewExtension.swift
//  
//
//  Created by alvaro.grimal.local on 10/6/22.
//

import Foundation
import SwiftUI

// MARK: View extension

extension View {
    public func isCiMAView(_ viewModel: Any) -> some View {
        modifier(CiMAView(viewModel: viewModel))
    }
}
