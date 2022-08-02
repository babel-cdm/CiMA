//
//  CiMAChildSizeReader.swift
//  
//
//  Created by Andres Heras Barrueco on 28/6/22.
//

import SwiftUI

struct CiMAChildSizeReader<Content: View>: View {

    @Binding var size: CGSize
    let content: () -> Content
    var body: some View {
        ZStack {
            content()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: CiMASizePreferenceKey.self, value: proxy.size)
                    }
                )
        }
        .onPreferenceChange(CiMASizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

struct CiMASizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
