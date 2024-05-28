//
//  ContentView.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharacterViewModel(apiClient: APIClient())
    @State var isLoading: Bool = false
    @State private var searchText = ""
    
    var filteredCharacters: [CharacterModel] {
        if let characters = viewModel.characters {
            guard !searchText.isEmpty else { return characters }
            return characters.filter({ $0.name.localizedCaseInsensitiveContains(searchText) })
        }
        return []
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(filteredCharacters, id:\.id) { character in
                        HStack {
                            if let url = character.image {
                                AsyncImage(url: URL(string: url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .clipShape(Circle())
                                        .frame(width: 40, height: 40)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 40, height: 40)
                            } else {
                                Image("siluette")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(100)
                                    .clipShape(Circle())
                                    .frame(width: 40, height: 40)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                    .shadow(radius: 10)
                                
                            }
                            Text(character.name)
                            Spacer()
                                .onAppear {
                                    if viewModel.isLastItem(character: character) {
                                        Task {
                                            await viewModel.loadMoreCharacters()
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Characters")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, prompt: "Search character")
        .overlay(
            viewModel.showLoading ? AnyView(ProgressView()) : AnyView(EmptyView()),
            alignment: .center
        )
        .onAppear{
            Task {
                await viewModel.getCharacters()
            }
        }
    }
}

#Preview {
    ContentView()
}
