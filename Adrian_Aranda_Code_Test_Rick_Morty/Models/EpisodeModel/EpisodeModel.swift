//
//  EpisodeModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct EpisodeModel {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String
    
    static var empty: Self {
        .init(id: 0, name: "", airDate: "", episode: "", characters: [], url: "", created: "")
    }
}
