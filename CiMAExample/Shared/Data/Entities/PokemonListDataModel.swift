//
//  PokemonListDataModel.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

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
    func domainModel() -> [PokemonDomainModel] {
        results?.map({ .init(name: $0.name ?? "") }) ?? []
    }
}
