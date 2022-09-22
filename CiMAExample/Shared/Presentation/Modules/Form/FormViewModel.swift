//
//  FormViewModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation

public protocol FormDelegate: AnyObject {
    func updateMain(with value: String)
}

final class FormViewModel: BaseViewModel<MainCoordinatorProtocol> {
    
    //MARK: - Properties
    @Published var formValue: String = ""
    private weak var delegate: FormDelegate?
    
    //MARK: - Init
    
    init(coordinator: MainCoordinatorProtocol,
         delegate: FormDelegate?) {
        self.delegate = delegate
        super.init(coordinator: coordinator)
    }
    
    //MARK: - Functions
    
    func acceptTapped() {
        delegate?.updateMain(with: formValue)
        getCoordinator()?.popForm()
    }
}

//MARK: - Testing

extension FormViewModel {
    static var sample: FormViewModel {
        let coordinator = MainCoordinator.sample
        let viewModel = DependencyInjector.shared.getFormViewModel(coordinator: coordinator,
                                                                   delegate: nil)
        return viewModel
    }
}
