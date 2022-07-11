//
//  URLSessionRepository.swift
//  CiMAExample (iOS)
//
//  Created by alvaro.grimal.local on 8/7/22.
//

import Foundation
import CiMA
import Combine

public class URLSessionRepository: HttpRepository {
    
    private static var repositoryInstance: URLSessionRepository?
    
    public static func shared() -> HttpRepository {
        if let repositoryInstance = URLSessionRepository.repositoryInstance {
            return repositoryInstance
        } else {
            URLSessionRepository.repositoryInstance = URLSessionRepository()
            return URLSessionRepository.repositoryInstance!
        }
    }
    
    public func getPokemonList() async throws -> [PokemonDomainModel] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            throw NSError(domain: "URL invalid", code: 404, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemonList = try JSONDecoder().decode(PokemonListDataModel.self, from: data)
        return pokemonList.parseToDomainModel()
    }
}
