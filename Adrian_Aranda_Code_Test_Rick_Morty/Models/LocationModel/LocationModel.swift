//
//  LocationModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct LocationModel {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    static var empty: Self {
        .init(id: 0, name: "", type: "", dimension: "", residents: [], url: "", created: "")
    }
}
