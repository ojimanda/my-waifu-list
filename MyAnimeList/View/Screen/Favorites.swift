//
//  Favorites.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 08/02/24.
//

import SwiftUI

struct Favorites: View {
    var body: some View {
        ZStack {
            Color.customBlue100.ignoresSafeArea()
            
            Text("Favorites")
        }
        .transition(.slide)
    }
}

#Preview {
    Favorites()
}
