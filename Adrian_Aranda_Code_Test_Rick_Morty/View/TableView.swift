//
//  TableView.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 29/5/24.
//

import SwiftUI

struct TableView: View {
    @Binding var searchText: String
    @Binding var selectedCharacter: CharacterModel?
    @Binding var pushView: Bool
    @EnvironmentObject var viewModel: CharacterViewModel
    
    var body: some View {
        ForEach(filteredCharacters, id:\.id) { character in
            Button(action: {
                Task {
                    let characterDetail = await viewModel.getCharacterDetails(character: character)
                    selectedCharacter = characterDetail
                    pushView.toggle()
                }
            }, label: {
                CharacterCell(character: character)
                .onAppear {
                    if viewModel.isLastItem(character: character) {
                        Task {
                            await viewModel.loadMoreCharacters()
                        }
                    }
                }
            })
        }
    }
    
    var filteredCharacters: [CharacterModel] {
        if let characters = viewModel.characters {
            guard !searchText.isEmpty else { return characters }
            return characters.filter({ $0.name.localizedCaseInsensitiveContains(searchText) })
        }
        return []
    }
}

#Preview {
    TableView(searchText: .constant(""), selectedCharacter: .constant(CharacterModel.empty), pushView: .constant(false)).environmentObject(CharacterViewModel(apiClient: APIClient()))
}
