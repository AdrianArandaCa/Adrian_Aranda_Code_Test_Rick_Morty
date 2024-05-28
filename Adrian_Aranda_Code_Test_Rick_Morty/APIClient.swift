//
//  APIClient.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

final class APIClient {
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    func getCharacters() async -> CharactersResponsesDataModel? {
        let urlCharacters = "character/"
        guard let url = URL(string: String(format: "%@%@", baseURL, urlCharacters)) else {
            fatalError("Missing URL")
        }
        let (data, response) = try! await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError ("Error while fetching data")}
        
        if let charactersResponsesDataModel = try? JSONDecoder().decode(CharactersResponsesDataModel.self, from: data) {
            print("\(charactersResponsesDataModel)")
            return charactersResponsesDataModel
        }
        return nil
    }
    
    func getMoreCharacters(url: String?) async -> CharactersResponsesDataModel? {
        if let urlCharacters = url {
            guard let url = URL(string: urlCharacters) else { fatalError("Missing URL") }
            let (data, response) = try! await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            if let charactersResponsesDataModel = try? JSONDecoder().decode(CharactersResponsesDataModel.self, from: data) {
                print("\(charactersResponsesDataModel)")
                return charactersResponsesDataModel
            }
            return nil
        }
        return nil
    }
}
