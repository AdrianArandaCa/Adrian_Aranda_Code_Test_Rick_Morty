//
//  CharacterModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct CharacterModel: Equatable {
    static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    let id: Int
    let name: String
//    let status: StatusType
    let status: String
//    let species: SpeciesType
    let species: String
    let type: String
//    let gender: GenderType
    let gender: String
    let origin, location: LocationModel?
    let image: String?
    let episode: [String]
    let url: String
    let created: String
    let locationResponseDataModel: LocationResponsesDataModel?
    let originResponseDataModel: LocationResponsesDataModel?
    
    static var empty: Self {
        .init(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: LocationModel.empty, location: LocationModel.empty, image: nil, episode: [], url: "", created: "", locationResponseDataModel: nil, originResponseDataModel: nil)
    }
}
