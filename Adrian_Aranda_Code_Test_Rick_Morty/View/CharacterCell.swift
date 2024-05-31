//
//  CharacterCell.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 29/5/24.
//

import SwiftUI

struct CharacterCell: View {
    var character: CharacterModel?
    var body: some View {
        if let character = character {
            HStack {
                if let url = character.image {
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                VStack(alignment: .leading, spacing: 4){
                    Text(character.name)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    Text(character.species)
                        .fontWeight(.regular)
                        .foregroundStyle(.black)
                }
                
                Spacer()
            }
            .background(.white)
            .cornerRadius(10)
            .frame(height:60)
        }
    }
    
}

#Preview {
    CharacterCell(character: .mockUp)
}
