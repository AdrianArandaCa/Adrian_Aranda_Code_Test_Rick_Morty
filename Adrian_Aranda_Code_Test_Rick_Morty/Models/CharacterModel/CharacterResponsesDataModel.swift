//
//  CharacterResponsesDataModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

enum GenderType: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

enum SpeciesType: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case humanoid = "Humanoid"
}

enum StatusType: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

struct CharactersResponsesDataModel: Decodable {
    var info: InfoResponsesDataModel
    var results: [CharacterResponsesDataModel]
    
    enum CodingKeys: CodingKey {
        case info
        case results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decode(InfoResponsesDataModel.self, forKey: .info)
        self.results = try container.decode([CharacterResponsesDataModel].self, forKey: .results)
    }
}

struct InfoResponsesDataModel: Decodable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
    
    enum CodingKeys: CodingKey {
        case count
        case pages
        case next
        case prev
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.pages = try container.decodeIfPresent(Int.self, forKey: .pages)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
        self.prev = try container.decodeIfPresent(String.self, forKey: .prev)
    }
}

struct CharacterResponsesDataModel: Decodable {
    let id: Int?
    let name: String?
//    var status: StatusType? = .unknown
    var status: String?
//    var species: SpeciesType? = .human
    var species: String?
    let type: String?
//    var gender: GenderType? = .unknown
    var gender: String?
    let origin, location: LocationResponsesDataModel?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.species = try container.decodeIfPresent(String.self, forKey: .species)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.origin = try container.decodeIfPresent(LocationResponsesDataModel.self, forKey: .origin)
        self.location = try container.decodeIfPresent(LocationResponsesDataModel.self, forKey: .location)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.episode = try container.decodeIfPresent([String].self, forKey: .episode)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
    }
}
