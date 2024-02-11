//
//  ContentView.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 07/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var selectedTab: ListTab = .home
    @State private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 10)
    ]
    @StateObject var animeViewModel = AnimeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBlue100.ignoresSafeArea()
                switch selectedTab {
                case .home:
                    Home(columns: $columns)
                        .tag(ListTab.home)
                case .favorite:
                    Favorites()
                        .tag(ListTab.favorite)
                case .profile:
                    Profile()
                        .tag(ListTab.profile)
                }
                
                if !animeViewModel.toDetail {
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
            }
        }
        .environmentObject(animeViewModel)
    }
}

#Preview {
    ContentView()
}
