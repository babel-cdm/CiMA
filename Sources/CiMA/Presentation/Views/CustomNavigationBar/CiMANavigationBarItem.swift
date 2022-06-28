//
//  CiMANavigationBarItem.swift
//
//
//  Created by Andres Heras Barrueco on 28/6/22.
//
import SwiftUI

// MARK: CiMANavigationBarItem Buttons
struct CiMANavigationBarItem: ViewModifier {
    
    let action: (() -> Void)?
    let alignement: Alignment
    let icon: String
    let colorButton: Color?
    
    init(action: (() -> Void)? = nil,
         icon: String,
         isLeft: Bool,
         colorButton: Color?) {
        
        self.action = action
        self.alignement = isLeft ? .leading : .trailing
        self.icon = icon
        self.colorButton = colorButton
    }
    
    public func body(content: Content) -> some View {
        
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(id: self.icon,
                            placement: self.buttonAlignement,
                            showsByDefault: true) {
                    CiMAShapeButton(action: action,
                                icon: self.icon,
                                alignement: self.alignement,
                                color: colorButton)
                }
            }
    }
    
    private var buttonAlignement: ToolbarItemPlacement {
        return self.alignement == .trailing ? .navigationBarTrailing : .navigationBarLeading
    }
}

struct CiMAShapeButton: View {
    
    let action: (() -> Void)?
    let icon: String
    let alignement: Alignment
    let color: Color?
    
    var body: some View {
        
        Image(self.icon)
            .renderingMode(.template)
            .foregroundColor(color ?? .black)
            .frame(alignment: self.alignement)
            .onTapGesture {
                action?()
            }
    }
}
