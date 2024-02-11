//
//  Favorites.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 08/02/24.
//

import SwiftUI

struct Favorites: View {
    
    @EnvironmentObject var viewModel: AnimeViewModel
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color.blue100.ignoresSafeArea()
                
                List(viewModel.favorites) { favorite in
                    CardFavorite(waifu: favorite)
                }
                .listRowSeparator(.hidden)
                .listRowSpacing(10)
            }
            .navigationTitle("Favorites")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear() {
            viewModel.getAllFavorites()
            print("data is: \(viewModel.favorites)")
        }
    }
}

//#Preview {
//    Favorites()
//}
