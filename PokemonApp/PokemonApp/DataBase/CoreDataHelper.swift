//
//  CoreDataHelper.swift
//  PokemonApp
//
//  Created by Василий Вырвич on 12.07.23.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static let shared = CoreDataHelper()

    lazy var context: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DBPokemon")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()

    func savePokemons(names: [String], urls: [String]) {
        guard names.count == urls.count else {
            return
        }
        
        for index in 0..<names.count {
            let pokemon = NSEntityDescription.insertNewObject(forEntityName: "DBPokemon", into: context) as! DBPokemon
            pokemon.name = names[index]
            pokemon.url = urls[index]
        }
        
        print(names)
        saveContext()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func deleteAllPokemons() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = DBPokemon.fetchRequest()
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Failed to delete pokemon entity: \(error)")
        }
    }
    
    func loadPokemons() -> [DBPokemon] {
            let context = persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<DBPokemon> = DBPokemon.fetchRequest()
            // Выполнение запроса
            do {
                let pokemons = try context.fetch(fetchRequest)
                return pokemons
            } catch {
                print("Ошибка загрузки покемонов: \(error)")
                return []
            }
        }
}


