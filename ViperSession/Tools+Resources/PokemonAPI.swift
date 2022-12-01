//
//  PokemonAPI.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 19/11/22.
//

import Alamofire
import AlamofireImage

class PokemonAPI {
    func pokemonInfo(request: ListEntity.PokemonRequest, completion: @escaping (Result<ListEntity.PokemonResponse, Error>) -> ())  {
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=\(request.limit)").responseDecodable(of: ListEntity.PokemonResponse.self) { response in
            switch response.result {
            case .success(let pokemons):
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func pokemonAbility(with request: DetailEntity.AbilityRequest, completion: @escaping (Result<DetailEntity.AbilityResponse, Error>) -> ())  {
        AF.request("https://pokeapi.co/api/v2/ability/\(request.pokemonId)").responseDecodable(of: DetailEntity.AbilityResponse.self) { response in
            switch response.result {
            case .success(let ability):                
                completion(.success(ability))                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
