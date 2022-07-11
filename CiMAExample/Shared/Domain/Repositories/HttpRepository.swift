//
//  HttpRepository.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation

public protocol HttpRepository {
    func getPokemonList() async throws -> [PokemonDomainModel]
}
