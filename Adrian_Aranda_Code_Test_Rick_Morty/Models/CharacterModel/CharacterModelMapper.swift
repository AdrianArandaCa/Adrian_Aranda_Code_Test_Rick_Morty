//
//  CharacterModelMapper.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct CharacterModelMapper {
    func mapCharacterResponsesToModel(model: CharacterResponsesDataModel) -> CharacterModel? {
        return CharacterModel(id: model.id ?? 0,
                              name: model.name ?? "",
                              status: model.status ?? "",
                              species: model.species ?? "",
                              type: model.type ?? "",
                              gender: model.gender ?? "",
                              origin: nil,
                              location: nil,
                              image: model.image ?? "",
                              episode: model.episode ?? [],
                              url: model.url ?? "",
                              created: model.created ?? "",
                              locationResponseDataModel: model.location,
                              originResponseDataModel: model.origin)
    }
}
