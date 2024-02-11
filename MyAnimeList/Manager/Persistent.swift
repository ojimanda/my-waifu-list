//
//  Persistent.swift
//  MyAnimeList
//
//  Created by Yozi Reci Manda on 11/02/24.
//

import Foundation
import CoreData


class PersistentController {
    static let shared = PersistentController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "MyAnimeList")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Could not load core data \(error.localizedDescription)")
                fatalError()
            }
        }
    }
    
    func saveChanges() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch (let error) {
                print("Could not save changes to Core Data.", error.localizedDescription)
            }
        }
    }
    
    func create(waifu: Anime) {
        let entity = Favorite(context: container.viewContext)
        
        entity.anime = waifu.anime
        entity.name = waifu.name
        entity.image = waifu.image
        
        saveChanges()
    }
    
    func read(predicate: String? = nil, fetchLimit: Int? = nil) -> [Favorite] {
        var results: [Favorite] = []
        
        let request = NSFetchRequest<Favorite>(entityName: "Favorite")
        
        
        // define filter
        if predicate != nil {
            request.predicate = NSPredicate(format: predicate!)
        }
        
        if fetchLimit != nil {
            request.fetchLimit = fetchLimit!
        }
        
        do {
            results = try container.viewContext.fetch(request)
        } catch (let error) {
            print("Could not fetch notes from Core Data.", error.localizedDescription)
        }
        
        return results
    }
    
    
    func update(entity: Favorite, name: String? = nil, anime: String? = nil, image: String? = nil) {
        // create a temp var to tell if an attribute is changed
        var hasChanges: Bool = false

        // update the attributes if a value is passed into the function
        if name != nil {
            entity.name = name!
            hasChanges = true
        }
        if anime != nil {
            entity.anime = anime!
            hasChanges = true
        }
        if image != nil {
            entity.image = image!
            hasChanges = true
        }

        // save changes if any
        if hasChanges {
            saveChanges()
        }
    }
    
    func delete(_ entity: Favorite) {
        container.viewContext.delete(entity)
        saveChanges()
    }
    
    func delete(withName name: String) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let favorites = try container.viewContext.fetch(fetchRequest)
            for fav in favorites {
                container.viewContext.delete(fav)
            }
        } catch {
            print("Failed to delete \(name) from favorite")
        }
    }

    
}
