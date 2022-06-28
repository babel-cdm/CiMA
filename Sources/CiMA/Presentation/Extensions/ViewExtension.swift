//
//  ViewExtension.swift
//  
//
//  Created by alvaro.grimal.local on 10/6/22.
//

import Foundation
import SwiftUI

extension View {
    
    // MARK: - CiMAView
    
    public func isCiMAView(_ viewModel: Any, with loadingView: AnyView? = nil) -> some View {
        return modifier(CiMAView(viewModel: viewModel,
                                 loadingViewModel: viewModel as! CiMALoadable,
                                 customLoadingView: loadingView))
    }
    
    // MARK: View navigation
    
    public func onNavigation(_ action: @escaping () -> Void) -> some View {
        let isActive = Binding(
            get: { false },
            set: { newValue in
                if newValue {
                    action()
                }
            }
        )
        return NavigationLink(
            destination: EmptyView(),
            isActive: isActive
        ) {
            self
        }
    }
    
    public func navigation<Item, Destination: View>(item: Binding<Item?>,
                                                    @ViewBuilder destination: (Item) -> Destination) -> some View {
        let isActive = Binding(
            get: {
                item.wrappedValue != nil
            },
            set: { value in
                if !value {
                    item.wrappedValue = nil
                }
            }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }
    
    public func navigation<Destination: View>(isActive: Binding<Bool>,
                                              @ViewBuilder destination: () -> Destination) -> some View {
        overlay(
            VStack(spacing: .zero) {
                NavigationLink(
                    destination: isActive.wrappedValue ? destination() : nil,
                    isActive: isActive,
                    label: { EmptyView() }
                )
                .isDetailLink(false)
                NavigationLink(destination: EmptyView(), label: {})
            }
        )
    }
    
    // MARK: Conditions
    
    public func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
