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

    // MARK: - Properties
    
    let viewModel: Any
    @ObservedObject var loadingViewModel: CiMALoadable
    let customLoadingView: AnyView?
    
    // MARK: - Static properties
    
    public static var defaultLoadingView: AnyView?

    // MARK: - View
    
    // For iOS 14.0.1 - 14.4 it should be done in main thread
    @MainActor public func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
            if loadingViewModel.isLoading {
                if let loadingView = customLoadingView {
                    loadingView
                } else {
                    getDefaultLoading()
                }
            }
        }
        .onAppear(perform: {
                guard let viewModel = viewModel as? LifecycleViewProtocol else { return }
                viewModel.onAppear()
            })
        .onDisappear(perform: {
            guard let viewModel = viewModel as? LifecycleViewProtocol else { return }
            viewModel.onDisappear()
        })
        .onTapGesture {
            //Hide keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }

    }
    
    // MARK: - Private functions
    
    private func getDefaultLoadingView() -> some View {
        ZStack {
            Color.white
                .opacity(0.5)
                .blur(radius: 3)
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
    
    private func getDefaultLoading() -> AnyView {
        if let defaultLoadingView = CiMAView.defaultLoadingView {
            return defaultLoadingView
        } else {
            return AnyView(getDefaultLoadingView())
        }
    }
}
