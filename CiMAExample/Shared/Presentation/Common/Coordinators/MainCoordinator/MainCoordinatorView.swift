//
//  MainCoordinatorView.swift
//  CiMAExample (iOS)
//

import Foundation
import SwiftUI

struct MainCoordinatorView: View {

    // MARK: - Properties
    
    @ObservedObject var coordinator: MainCoordinator

    // MARK: - Body
    
    var body: some View {
        NavigationView {
            getMainView()
        }
    }
    
    // MARK: - Views
    
    func getMainView() -> some View {
        MainView(viewModel: coordinator.mainViewModel)
            .navigation(isActive: $coordinator.formIsActive,
                        destination: { getFormView() })
            .navigation(isActive: $coordinator.pokemonIsActive,
                        destination: { getPokemonView() })
    }
    
    func getFormView() -> some View {
        FormView(viewModel: coordinator.formViewModel)
    }
    
    func getPokemonView() -> some View {
        PokemonListView(viewModel: coordinator.pokemonViewModel)
    }
}

// MARK: - Previews

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView(coordinator: MainCoordinator.sample)
    }
}
