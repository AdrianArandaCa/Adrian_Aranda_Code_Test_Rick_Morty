//
//  LocationResponsesDataModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct LocationResponsesDataModel: Decodable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case type
        case dimension
        case residents
        case url
        case created
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.dimension = try container.decodeIfPresent(String.self, forKey: .dimension)
        self.residents = try container.decodeIfPresent([String].self, forKey: .residents)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
    }
}
