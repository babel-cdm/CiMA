//
//  MainView.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: MainViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Text("Welcome \(viewModel.formValue)")
            Button("Form test", action: viewModel.flowTestTapped)
            Button("API test", action: viewModel.apiTestTapped)
        }
        .isCiMAView(viewModel)
    }
}

// MARK: - Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel.sample)
    }
}
