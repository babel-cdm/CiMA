//
//  PokemonListView.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import SwiftUI

struct PokemonListView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: PokemonListViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ForEach(viewModel.pokemonList, id: \.self) {
                Text($0)
            }
        }
        .isCiMAView(viewModel)
    }
}

// MARK: - Previews

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(viewModel: PokemonListViewModel.sample)
    }
}
