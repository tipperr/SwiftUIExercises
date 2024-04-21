//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ciaran Murphy on 4/21/24.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        resorts = []
        load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        resorts.remove(resort.id)
        save()
    }
    
//    func save(){
//        let data = try? JSONEncoder().encode(key)
//        UserDefaults.standard.set(data, forKey: key)
//    }
    
    func save(){
        let data = try? JSONEncoder().encode(resorts)
        UserDefaults.standard.set(data, forKey: key)
    }

    
    func load(){
        if let data = UserDefaults.standard.data(forKey: key),
           let loadedResorts = try? JSONDecoder().decode(Set<String>.self, from: data) {
            resorts = loadedResorts
        }
    }

}
