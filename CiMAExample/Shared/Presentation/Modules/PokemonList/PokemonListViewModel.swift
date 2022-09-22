//
//  PokemonListViewModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import CiMA
import Combine

final class PokemonListViewModel: BaseViewModel<MainCoordinatorProtocol> {
    
    // MARK: - Properties
    
    @Published var pokemonList: [String] = []
    private let pokemonListUseCase: PokemonListUseCase
    private let isCompletionRequestSelected: Bool
    var subscriptions = [AnyCancellable]()
    
    // MARK: - Functions
    
    init(coordinator: MainCoordinatorProtocol,
         pokemonListUseCase: PokemonListUseCase,
         isCompletionRequestSelected: Bool) {
        self.isCompletionRequestSelected = isCompletionRequestSelected
        self.pokemonListUseCase = pokemonListUseCase
        super.init(coordinator: coordinator)
    }
    
    // MARK: - Functions
    
    override func onAppear() {
        super.onAppear()
        if isCompletionRequestSelected {
            getPokemonListCompletion()
        } else {
            Task {
                await getPokemonListAsync()
            }
        }
    }

    @MainActor
    private func getPokemonListAsync() async {
        do {
            let pokemons = try await pokemonListUseCase.execute()
            pokemonList = pokemons?.map({ $0.name }) ?? []
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getPokemonListCompletion(){
        
        pokemonListUseCase.execute()
            .sink { _ in
            } receiveValue: { pokemons in
                self.pokemonList = pokemons.map({ $0.name }) 
            }
            .store(in: &subscriptions)
    }
}

//MARK: - Testing

extension PokemonListViewModel {
    static var sample: PokemonListViewModel {
        let coordinator = MainCoordinator.sample
        let viewModel = DependencyInjector.shared.getPokemonListViewModel(coordinator: coordinator, isCompletionRequestSelected: false)
        return viewModel
    }
}
