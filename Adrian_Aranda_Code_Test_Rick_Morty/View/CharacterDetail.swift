//
//  CharacterDetail.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 29/5/24.
//

import SwiftUI

struct CharacterDetail: View {
    var character: CharacterModel
    var body: some View {
        VStack {
            GeometryReader(content: { geometry in
                let size = geometry.size
                
                if let url = character.image {
                    AsyncImage(url: URL(string: url)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                    } placeholder: {
                        ProgressView()
                    }
                }
            })
            .frame(height: 400)
            .ignoresSafeArea()
            if character.name != "" {
                TextRandomChange(text: character.name, trigger: true, transition: .identity, speed: 0.06)
                    .font(.largeTitle.bold())
            }
            Spacer()
            
        }
    }
}

struct TextRandomChange: View {
    var text: String
    var trigger: Bool
    var transition: ContentTransition = .interpolate
    var duration: CGFloat = 1.0
    var speed: CGFloat = 0.1
    
    @State private var animatedText: String = ""
    @State private var randomCharacters: [Character] = {
        let string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUWVXYZ0123456789-?/#$%!^&*()="
        return Array(string)
    }()
    var body: some View {
        Text(animatedText)
            .fontDesign(.monospaced)
            .truncationMode(.tail)
            .contentTransition(transition)
            .animation(.easeInOut(duration: 0.1), value: animatedText)
            .onAppear {
                guard animatedText.isEmpty else { return }
                setRandomCharacters()
                animateText()
            }
            .customOnChange(value: trigger) { newValue in
                animateText()
            }
    }
    
    private func animateText() {
        for index in text.indices {
            let delay = CGFloat.random(in: 0...duration)
            let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
                guard let randomCharacter = randomCharacters.randomElement() else { return }
                replaceCharacter(at: index, character: randomCharacter)
                
            }
            timer.fire()
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if text.indices.contains(index) {
                    let actualCharacter = text[index]
                    replaceCharacter(at: index, character: actualCharacter)
                }
                timer.invalidate()
            }
        }
    }
    
    private func setRandomCharacters() {
        animatedText = text
        for index in self.animatedText.indices {
            guard let randomCharacter = randomCharacters.randomElement() else { return }
            replaceCharacter(at: index, character: randomCharacter)
        }
    }
    
    func replaceCharacter(at index: String.Index, character: Character) {
        guard self.animatedText.indices.contains(index) else { return }
        let indexCharacter = String(self.animatedText[index])
        
        if indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            self.animatedText.replaceSubrange(index...index, with: String(character))
        }
    }
}

fileprivate extension View {
    @ViewBuilder
    func customOnChange<T: Equatable>(value: T, result: @escaping (T) -> ()) -> some View {
        if #available(iOS 17, *) {
            self.onChange(of: value) { oldValue, newValue in
                result(newValue)
            }
        } else {
            self.onChange(of: value, perform: { value in
                result(value)
            })
        }
    }
}

#Preview {
    CharacterDetail(character: .empty)
}