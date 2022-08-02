//
//  PokemonListViewModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import CiMA

final class PokemonListViewModel: BaseViewModel<MainCoordinatorProtocol> {
    
    // MARK: - Properties
    
    @Published var pokemonList: [String] = []
    private let pokemonListUseCase: PokemonListUseCase
    
    // MARK: - Functions
    
    init(coordinator: MainCoordinatorProtocol,
         pokemonListUseCase: PokemonListUseCase) {
        self.pokemonListUseCase = pokemonListUseCase
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Functions
    
    override func onAppear() {
        super.onAppear()
        Task {
            await getPokemonList()
        }
    }

    @MainActor
    private func getPokemonList() async {
        do {
            let pokemons = try await pokemonListUseCase.execute()
            pokemonList = pokemons?.map({ $0.name }) ?? []
        } catch {
            print(error.localizedDescription)
        }
    }
}

//MARK: - Testing

extension PokemonListViewModel {
    static var sample: PokemonListViewModel {
        let coordinator = MainCoordinator.sample
        let viewModel = DependencyInjector.shared.getPokemonListViewModel(coordinator: coordinator)
        return viewModel
    }
}
