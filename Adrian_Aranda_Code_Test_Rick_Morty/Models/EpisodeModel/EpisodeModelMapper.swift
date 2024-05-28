//
//  EpisodeModelMapper.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct EpisodeModelMapper {
    func mapEpisodeResponsesToModel(model: EpisodeResponsesDataModel) -> EpisodeModel? {
        return EpisodeModel.init(id: model.id, name: model.name, airDate: model.airDate, episode: model.episode, characters: model.characters, url: model.url, created: model.created)
    }
}
