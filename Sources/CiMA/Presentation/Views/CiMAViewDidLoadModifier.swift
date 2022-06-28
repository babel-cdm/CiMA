//
//  CiMAViewDidLoadModifier.swift
//  
//
//  Created by Andres Heras Barrueco on 28/6/22.
//

import SwiftUI

struct CiMAViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}
