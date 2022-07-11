//
//  PokemonListDataModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation

// MARK: - PokemonListDataModel

struct PokemonListDataModel: Decodable {
    let count: Int?
    let results: [PokemonDataModel]?
}

// MARK: - PokemonDataModel

struct PokemonDataModel: Decodable {
    let name: String?
    let url: String?
}

// MARK: - Extension PokemonListDataModel

extension PokemonListDataModel {
    func parseToDomainModel() -> [PokemonDomainModel] {
        results?.map({ .init(name: $0.name ?? "") }) ?? []
    }
}
