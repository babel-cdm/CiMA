//
//  FormView.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import SwiftUI

struct FormView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: FormViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            TextField("Type your name", text: $viewModel.formValue)
                .textFieldStyle(.roundedBorder)
            Button("Accept", action: viewModel.acceptTapped)
        }
        .isCiMAView(viewModel)
    }
}

// MARK: - Previews

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(viewModel: FormViewModel.sample)
    }
}
