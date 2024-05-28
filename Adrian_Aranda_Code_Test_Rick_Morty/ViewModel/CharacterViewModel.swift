//
//  CharacterViewModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

enum CustomError:String, Error {
    case error = "Error"
}

class CharacterViewModel: ObservableObject {
    @Published private(set) var characters: [CharacterModel]?
    @Published private(set) var charactersResponsesDataModel: CharactersResponsesDataModel?
    @Published private(set) var showLoading: Bool = false
    private let charactersModelMapper = CharacterModelMapper()

    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func getCharacters() async {
        showLoading = true
        Task {
            do {
                if let charactersResponsesDataModel = await apiClient.getCharacters() {
                    self.charactersResponsesDataModel = charactersResponsesDataModel
                    characters = getCharactersModel(charactersResponsesDataModel: charactersResponsesDataModel)
                }
                
            } catch let error as CustomError {
                print(error)
            }
            showLoading = false
        }
    }
    
    @MainActor
    func loadMoreCharacters() async {
        showLoading = true
        Task {
            do {
                let moreCharacters = await apiClient.getMoreCharacters(url: charactersResponsesDataModel?.info.next ?? nil)
                if moreCharacters != nil {
                    self.charactersResponsesDataModel = moreCharacters
                    if let characterResponsesDataModel = charactersResponsesDataModel {
                        characters?.append(contentsOf: getCharactersModel(charactersResponsesDataModel: characterResponsesDataModel))
                    }
                }
            } catch let error as CustomError {
                print(error)
            }
            showLoading = false
        }
    }
    
    private func getCharactersModel(charactersResponsesDataModel: CharactersResponsesDataModel) -> [CharacterModel] {
        var charactersModel = [CharacterModel]()
        let characters = charactersResponsesDataModel.results
        charactersModel.append(contentsOf: getCharacterModel(characterResponsesDataModel: characters))
        return charactersModel
    }
    
    private func getCharacterModel(characterResponsesDataModel: [CharacterResponsesDataModel]) -> [CharacterModel] {
        var charactersModel = [CharacterModel]()
        for character in characterResponsesDataModel {
            if let characterModelMapper = charactersModelMapper.mapCharacterResponsesToModel(model: character) {
                charactersModel.append(characterModelMapper)
            }
        }
        return charactersModel
    }
    
    func isLastItem(character: CharacterModel) -> Bool {
        guard let index = self.characters?.firstIndex(where: { $0.name == character.name }) else { return false }
        return index == (characters?.count ?? 0) - 1
    }
}
