//
//  HttpRepository.swift
//  CiMAExample (iOS)
//

import Foundation
import CiMA

public protocol HttpRepository {
    func getPokemonList() async throws -> [PokemonDomainModel]

    func getPokemonListCombine() -> CiMAObservable<[PokemonDomainModel]>
}
