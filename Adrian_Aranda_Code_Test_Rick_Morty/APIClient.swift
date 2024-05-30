//
//  APIClient.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
}

final class APIClient {
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    func getCharacters() async throws -> CharactersResponsesDataModel? {
        let urlCharacters = "character/"
        guard let url = URL(string: String(format: "%@%@", baseURL, urlCharacters)) else { throw CustomError.invalidURL }
        do {
            let (data, response) = try! await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CustomError.invalidResponse }
            do {
                let charactersResponsesDataModel = try JSONDecoder().decode(CharactersResponsesDataModel.self, from: data)
                print("\(charactersResponsesDataModel)")
                return charactersResponsesDataModel
            } catch {
                throw CustomError.decodingError(error)
            }
        } catch {
            throw CustomError.networkError(error)
        }
    }
    
    func getMoreCharacters(url: String?) async throws -> CharactersResponsesDataModel? {
        if let urlCharacters = url {
            guard let url = URL(string: urlCharacters) else { throw CustomError.invalidURL }
            do {
                let (data, response) = try! await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CustomError.invalidResponse }
                do {
                    let charactersResponsesDataModel = try JSONDecoder().decode(CharactersResponsesDataModel.self, from: data)
                    print("\(charactersResponsesDataModel)")
                    return charactersResponsesDataModel
                } catch {
                    throw CustomError.decodingError(error)
                }
            } catch {
                throw CustomError.networkError(error)
            }
        }
        return nil
    }
    
    func getLocation(url: String?) async throws -> LocationResponsesDataModel? {
        if let urlLocation = url {
            guard let url = URL(string: urlLocation) else { throw CustomError.invalidURL }
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CustomError.invalidResponse }
                do {
                    let locationResponsesDataModel = try JSONDecoder().decode(LocationResponsesDataModel.self, from: data)
                    print("\(locationResponsesDataModel)")
                    return locationResponsesDataModel
                } catch {
                    throw CustomError.decodingError(error)
                }
                
            } catch {
                throw CustomError.networkError(error)
            }
        }
        return nil
    }
    
    func getEpisode(url: String?) async throws -> EpisodeResponsesDataModel? {
        if let urlEpisode = url {
            guard let url = URL(string: urlEpisode) else { throw CustomError.invalidURL }
            do {
                let (data, response) = try! await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw CustomError.invalidResponse }
                do {
                    let episodeResponsesDataModel = try JSONDecoder().decode(EpisodeResponsesDataModel.self, from: data)
                    print("\(episodeResponsesDataModel)")
                    return episodeResponsesDataModel
                } catch {
                    throw CustomError.decodingError(error)
                }
            } catch {
                throw CustomError.networkError(error)
            }
        }
        return nil
    }
}
