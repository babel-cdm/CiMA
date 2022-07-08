//
//  NavigationBarViewModifier.swift
//  
//
//  Created by Andres Heras Barrueco on 28/6/22.
//

import SwiftUI

extension View {
    
    public func navigationBarButton(action: (() -> Void)? = nil, icon: String, isLeft: Bool? = nil, colorButton: Color? = nil) -> some View {
        
        self.modifier(CiMANavigationBarItem(action: action,
                                        icon: icon,
                                        isLeft: isLeft ?? false,
                                        colorButton: colorButton))
    }
}
