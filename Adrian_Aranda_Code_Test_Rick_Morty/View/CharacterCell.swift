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
                            .cornerRadius(20)
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 40, height: 40)
                }
                Text(character.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Spacer()
            }
        }
    }
    
}

#Preview {
    CharacterCell(character: .empty)
}
