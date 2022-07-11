//
//  CiMAExampleApp.swift
//  Shared
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import SwiftUI

@main
struct CiMAExampleApp: App {

    @StateObject var coordinator = MainCoordinator.sample
    
    var body: some Scene {
        WindowGroup {
            initialView()
        }
    }
    
    private func initialView() -> some View {
        return MainCoordinatorView(coordinator: coordinator)
    }
}
