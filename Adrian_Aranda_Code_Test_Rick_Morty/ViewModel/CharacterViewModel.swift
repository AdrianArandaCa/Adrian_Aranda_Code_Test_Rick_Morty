//
//  CharacterViewModel.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

enum LocationType:String {
    case location = "location"
    case origin = "origin"
}

class CharacterViewModel: ObservableObject {
    @Published private(set) var characters: [CharacterModel]?
    @Published private(set) var charactersResponsesDataModel: CharactersResponsesDataModel?
    @Published private(set) var showLoading: Bool = false
    private let charactersModelMapper = CharacterModelMapper()
    private let locationModelMapper = LocationModelMapper()
    private let episodeModelMapper = EpisodeModelMapper()

    
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
                
            } catch {
                print("error")
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
            } catch {
                print("error")
            }
            showLoading = false
        }
    }
    
    func getLocation(character: CharacterModel, locationType: LocationType) async -> LocationModel? {
        var characterDetail: CharacterModel = .empty
        characterDetail = character
        do {
            switch locationType {
            case .location:
                if characterDetail.locationResponseDataModel?.url != "", let location = try await self.apiClient.getLocation(url: characterDetail.locationResponseDataModel?.url) {
                    print("RESPONSE LOCATIONRESPONSESDATAMODEL: \(location)")
                    return getLocationModel(locationResponsesDataModel: location)
                }
            case .origin:
                if characterDetail.originResponseDataModel?.url != "", let origin = try await self.apiClient.getLocation(url: /*characterDetail.originResponseDataModel?.url*/"") {
                    print("RESPONSE ORIGINRESPONSESDATAMODEL: \(origin)")
                    return getLocationModel(locationResponsesDataModel: origin)
                }
            }
            
        } catch CustomError.invalidURL {
            print("Invalid URL provided \(locationType.rawValue)")
        } catch CustomError.invalidResponse {
            print("Invalid response from server \(locationType.rawValue)")
        } catch CustomError.decodingError(let error) {
            print("Decoding error: \(error) \(locationType.rawValue)")
        } catch CustomError.networkError(let error) {
            print("Network error: \(error) \(locationType.rawValue)")
        } catch {
            print("An unexpected error ocurred \(error)")
        }
        return nil
    }
    
    @MainActor
    func getCharacterDetails(character: CharacterModel) async -> CharacterModel {
        showLoading = true
        var characterDetail: CharacterModel = .empty
        characterDetail = character
        
        characterDetail.origin = await getLocation(character: character, locationType: .origin)
        characterDetail.location = await getLocation(character: character, locationType: .location)
        
        showLoading = false
        return characterDetail
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
    
    private func getLocationModel(locationResponsesDataModel: LocationResponsesDataModel) -> LocationModel? {
        var locationModel: LocationModel?
        if let locationModelMapper = locationModelMapper.mapLocationResponsesToModel(model: locationResponsesDataModel) {
            locationModel = locationModelMapper
        }
        return locationModel
    }
    
    func isLastItem(character: CharacterModel) -> Bool {
        guard let index = self.characters?.firstIndex(where: { $0.name == character.name }) else { return false }
        return index == (characters?.count ?? 0) - 1
    }
}
