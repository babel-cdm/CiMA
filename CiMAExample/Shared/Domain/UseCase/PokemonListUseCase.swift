//
//  PokemonListUseCase.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import CiMA

final class PokemonListUseCase: CiMAUseCase<Void, [PokemonDomainModel]> {
    
    private let urlSessionRepository: HttpRepository
    
    init(urlSessionRepository: HttpRepository) {
        self.urlSessionRepository = urlSessionRepository
        super.init()
    }

    public override func handle(input: Void? = nil) async throws -> [PokemonDomainModel]? {
        try await urlSessionRepository.getPokemonList()
    }

    public override func handle(input: Void? = nil) -> CiMAObservable<[PokemonDomainModel]> {
       urlSessionRepository.getPokemonListCombine()
    }

}
