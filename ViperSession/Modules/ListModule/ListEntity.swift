//
//  ListEntity.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 13/11/22.
//

import Foundation

struct ListEntity {
    struct PokemonRequest {
        let limit: Int
    }
    
    struct Pokemon: Decodable {
        
        let name: String
        let url: String
        
        var id: Int? {
            return Int(url.split(separator: "/").last?.description ?? "0")
        }
        
        var imageUrl2: URL? {
            var idString: String = String(id ?? 0)
            if idString.count == 1 {
                idString = "00\(idString)"
            }else if idString.count == 2 {
                idString = "0\(idString)"
            }
            return URL(string: "https://assets.pokemon.com/assets/cms2/img/pokedex/full/\(idString).png")
        }
    }
    
    struct PokemonResponse: Decodable {        
        let results: [Pokemon]
    }
}
