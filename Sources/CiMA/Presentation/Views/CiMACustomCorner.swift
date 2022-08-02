//
//  CiMACustomCorner.swift
//  
//
//  Created by Andres Heras Barrueco on 28/6/22.
//

import SwiftUI

struct CiMACustomCorner: Shape {
    
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
