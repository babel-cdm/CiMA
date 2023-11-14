//
//  HttpRepository.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import CiMA

public protocol HttpRepository {
    func getPokemonList() async throws -> [PokemonDomainModel]
    func getPokemonList() -> CiMAObservable<[PokemonDomainModel]>
}
