//
//  CoreDataManager.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 11/02/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MyAnimeList")
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
            print("Data saved...")
        } catch(let error) {
            print("Could not save the data \(error.localizedDescription)")
        }
    }
    
    func addFavorite(anime: String, image: String, name: String) {
        let waifu = Favorite(context: persistentContainer.viewContext)
        waifu.name = name
        waifu.anime = anime
        waifu.image = image
        
        save()
        print("Success add to favorite")
    }
    
}
