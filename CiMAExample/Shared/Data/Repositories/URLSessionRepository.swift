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
            throw RepositoryError.urlError
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let pokemonList = try JSONDecoder().decode(PokemonListDataModel.self, from: data)
        return pokemonList.domainModel()
    }

    public func getPokemonList() -> CiMAObservable<[PokemonDomainModel]> {
        .just([])
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
//            return .init(Fail(error: RepositoryError.decodeError))
//        }

//        return URLSession.shared.dataTaskPublisher(for: url)
//            .flatMap { (data, _) -> CiMAObservable<[PokemonDomainModel]> in
//                guard
//                    let pokemonList = try? JSONDecoder().decode(PokemonListDataModel.self, from: data).domainModel()
//                else {
//                    return .failure(RepositoryError.decodeError)
//                }
//                return .just(pokemonList)
//            }
    }
}

private enum RepositoryError {
    static var urlError: Error { NSError(domain: "URL invalid", code: 404, userInfo: nil) as Error }
    static var decodeError: Error { NSError(domain: "Error decoding", code: -1000, userInfo: nil) as Error }
}
