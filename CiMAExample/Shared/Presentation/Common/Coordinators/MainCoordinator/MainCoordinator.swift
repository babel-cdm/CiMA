//
//  MainCoordinator.swift
//  CiMAExample (iOS)
//

import Foundation

public protocol MainCoordinatorProtocol: BaseCoordinatorProtocol {
    func navigateToForm(delegate: FormDelegate)
    func popForm()
    func navigateToPokemon(isCompletionRequestSelected: Bool)
}

public class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol {
    
    //MARK: - Properties
    
    @Published private(set) var mainViewModel: MainViewModel!
    @Published private(set) var formViewModel: FormViewModel!
    @Published private(set) var pokemonViewModel: PokemonListViewModel!
    @Published var formIsActive: Bool = false
    @Published var pokemonIsActive: Bool = false
    
    //MARK: - Navigation methods
    
    func navigateToMain() {
        mainViewModel = DependencyInjector.shared.getMainViewModel(coordinator: self)
    }
    
    public func navigateToForm(delegate: FormDelegate) {
        formViewModel = DependencyInjector.shared.getFormViewModel(coordinator: self,
                                                                   delegate: delegate)
        formIsActive = true
    }
    
    public func popForm() {
        formIsActive = false
    }
    
    public func navigateToPokemon(isCompletionRequestSelected: Bool) {
        pokemonViewModel = DependencyInjector.shared.getPokemonListViewModel(coordinator: self, isCompletionRequestSelected: isCompletionRequestSelected)
        pokemonIsActive = true
    }
}

//MARK: - Initialize

extension MainCoordinator {
    static var sample: MainCoordinator {
        let coordinator = MainCoordinator()
        coordinator.navigateToMain()
        return coordinator
    }
}
