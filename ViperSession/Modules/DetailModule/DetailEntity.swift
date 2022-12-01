//
//  DetailEntity.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 29/11/22.
//

import Foundation

struct DetailEntity {
    struct AbilityRequest {
        let pokemonId: String
    }
    
    struct AbilityResponse: Decodable {
        let effectEntries: [EffectEntries]
        
        struct EffectEntries: Decodable {
            let effect: String
            let language: Language
            let shortEffect: String
            
            enum CodingKeys: String, CodingKey {
                case shortEffect = "short_effect"
                case language
                case effect
            }
        }
        
        struct Language: Decodable {
            let name: String
        }
        
        enum CodingKeys: String, CodingKey {
            case effectEntries = "effect_entries"
        }
    }
    
    struct Ability {
        let shortEffect: String
    }
}
