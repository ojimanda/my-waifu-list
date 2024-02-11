//
//  AnimeViewModel.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 09/02/24.
//

import Foundation


class AnimeViewModel: ObservableObject {
    
    @Published var waifus: [Anime] = []
    @Published var selectedWaifu: Anime = MockData.dummy
    
    @Published var favWaifus: [Anime] = []
    @Published var searchText: String = ""
    @Published var error: String = ""
    @Published var isLoading: Bool = false
    
    @Published var toDetail: Bool = false
    
    
    // Core Data
    @Published var favorites: [Favorite] = []
    
    let dataService = PersistentController.shared
    
    init() {
        Task {
            await getWaifus()
        }
        getAllFavorites()
    }

    
    @MainActor
    func getWaifus() async {
        
        self.isLoading = true
        do {
            
            try await AnimeService.shared.allWaifu { [weak self] result in
                switch result {
                case .success(let waifus):
                    self?.waifus = waifus
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            }
            
        } catch(let error) {
            self.error = error.localizedDescription
        }
        self.isLoading = false
    }
    
    
    var filteredWaifu: [Anime] {
        guard !searchText.isEmpty  else {
            return waifus
        }
        
        return waifus.filter { waifu in
            waifu.name.localizedCaseInsensitiveContains(searchText) || waifu.anime.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func deleteWaifu(with waifu: Anime) {
        
        var newObj: [Anime] = []
        
        for obj in waifus {
            if obj != waifu {
                newObj.append(obj)
            }
        }
        waifus = newObj
        print("waifu \(waifu) has been deleted")
    }
    
    func isFavWaifu(waifu: Anime) -> Bool {
        var isFav = false
        for obj in favorites {
            if waifu.name == obj.name {
                isFav = true
            }
        }
        return isFav
    }
    
    func addOrRemoveWaifu(waifu: Anime) {
        if !isFavWaifu(waifu: waifu) {
            addFavorites(waifu: waifu)
        } else {
            deleteFavorite(withName: waifu.name)
        }
    }
    
    // function handle core data
    
    func getAllFavorites() {
        favorites = dataService.read()
    }
    
    func addFavorites(waifu: Anime) {
        dataService.create(waifu: waifu)
        getAllFavorites()
    }
    
    func deleteFavorite(withName name: String) {
        
        dataService.delete(withName: name)
        getAllFavorites()
    }
    
}
