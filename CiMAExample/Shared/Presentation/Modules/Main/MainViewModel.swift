//
//  MainViewModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation

final class MainViewModel: BaseViewModel<MainCoordinatorProtocol>,
                           FormDelegate {
    
    //MARK: - Properties
    
    @Published var formValue: String = ""
    
    //MARK: - Functions
    
    func flowTestTapped() {
        getCoordinator()?.navigateToForm(delegate: self)
    }

    func apiTestTapped() {
        getCoordinator()?.navigateToPokemon()
    }
    
    //MARK: - FormDelegate
    
    func updateMain(with value: String) {
        formValue = value
    }
}

//MARK: - Testing

extension MainViewModel {
    static var sample: MainViewModel {
        let coordinator = MainCoordinator.sample
        let viewModel = DependencyInjector.shared.getMainViewModel(coordinator: coordinator)
        return viewModel
    }
}
