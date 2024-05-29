//
//  ContentView.swift
//  Adrian_Aranda_Code_Test_Rick_Morty
//
//  Created by Adrian Aranda Campanario on 28/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CharacterViewModel(apiClient: APIClient())
    @FocusState private var isSearching: Bool
    @State var isLoading: Bool = false
    @State private var searchText = ""
    @State var selectedCharacter: CharacterModel?
    @State var pushView: Bool = false
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                TableView(searchText: $searchText, selectedCharacter: $selectedCharacter, pushView: $pushView).environmentObject(viewModel)
            }
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0) {
                ExpandableNavigationBar()
            }
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: isSearching)
        }
        .background(.gray.opacity(0.15))
        .contentMargins(.top, 120, for: .scrollIndicators)
        .overlay(
            viewModel.showLoading ? AnyView(ProgressView()) : AnyView(EmptyView()),
            alignment: .center
        )
        .onAppear{
            Task {
                await viewModel.getCharacters()
            }
        }
        .sheet(isPresented: $pushView) {
            if let selectedCharacter = selectedCharacter {
                CharacterDetail(character: selectedCharacter)
            } else {
                EmptyView()
            }
        }
        .onChange(of: selectedCharacter, { oldValue, newValue in
            if newValue != nil {
                pushView = true
            }
        })
    }
    
    @ViewBuilder
    func ExpandableNavigationBar(_ title: String = "Characters") -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = proxy.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let scaleProgress = minY > 0 ? 1 + (max(min(minY / scrollViewHeight, 1), 0) * 0.5) : 1
            let progress = isSearching ? 1 : max(min(-minY / 70, 1), 0)
            VStack(spacing: 10) {
                Text(title)
                    .font(.largeTitle.bold())
                    .scaleEffect(scaleProgress, anchor: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                    TextField("Search character", text: $searchText)
                        .focused($isSearching)
                    
                    if isSearching {
                        Button(action: {
                            isSearching = false
                            searchText = ""
                        }) {
                            Image(systemName: "xmark")
                                .font(.title3)
                        }
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                    }
                }
                .foregroundStyle(Color.primary)
                .padding(.vertical, 10)
                .padding(.horizontal, 15 - (progress * 15))
                .frame(height: 45)
                .clipShape(.capsule)
                .background{
                    RoundedRectangle(cornerRadius: 25 - (progress * 25))
                        .fill(.background)
                        .shadow(color: .gray.opacity(0.25), radius: 5, x:0, y:5)
                        .padding(.top, -progress * 190)
                        .padding(.bottom, -progress * 15)
                        .padding(.horizontal, -progress * 15)
                }
            }
            .padding(.top, 25)
            .safeAreaPadding(.horizontal, 15)
            .offset(y: minY < 0 || isSearching ? -minY : 0)
            .offset(y: -progress * 65)
        }
        .frame(height: 120)
        .padding(.bottom, 10)
        .padding(.bottom, isSearching ? -65 : 0)
    }
}

struct CustomScrollTargetBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 70 {
            if target.rect.minY < 35 {
                target.rect.origin = .zero
            } else {
                target.rect.origin = .init(x: 0, y: 70)
            }
        }
    }
}

#Preview {
    ContentView()
}
