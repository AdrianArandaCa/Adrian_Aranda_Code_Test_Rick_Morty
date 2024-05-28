//
//  LocationModelMapper.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

struct LocationModelMapper {
    func mapLocationResponsesToModel(model: LocationResponsesDataModel) -> LocationModel? {
        return LocationModel.init(id: model.id ?? 0, name: model.name ?? "", type: model.type ?? "", dimension: model.dimension ?? "", residents: model.residents ?? [], url: model.url ?? "", created: model.created ?? "")
    }
}
