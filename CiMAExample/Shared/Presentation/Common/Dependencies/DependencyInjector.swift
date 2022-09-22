//
//  DependencyInjector.swift
//  CiMAExample (iOS)
//
//  Created by Andres Heras Barrueco on 22/9/22.
//

import Foundation

final class DependencyInjector {
    static let shared = DependencyInjector()
    
    func getMainViewModel(coordinator: MainCoordinator) -> MainViewModel {
        .init(coordinator: coordinator)
    }
    
    func getPokemonListViewModel( coordinator: MainCoordinator, isCompletionRequestSelected: Bool) -> PokemonListViewModel {
        return PokemonListViewModel(coordinator: coordinator, pokemonListUseCase: getPokemonListUseCase(), isCompletionRequestSelected: isCompletionRequestSelected)
    }
    
    func getFormViewModel(coordinator: MainCoordinator, delegate: FormDelegate? = nil) -> FormViewModel{
        return FormViewModel(coordinator: coordinator, delegate: delegate)
    }
    
    func getPokemonListUseCase() -> PokemonListUseCase {
        return PokemonListUseCase(urlSessionRepository: getHttRepository())
    }
    
    func getHttRepository() -> HttpRepository {
        return URLSessionRepository.shared()
    }
}
