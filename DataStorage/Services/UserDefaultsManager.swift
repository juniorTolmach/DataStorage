//
//  UserDefaultsManager.swift
//  DataStorage
//
//  Created by Daniil Oreshenkov on 11.09.2022.
//

import Foundation

struct UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "Family"
    
    private init() {}
    
    func save(newFamilyMember: Family) {
        var family = fetchFamily()
        family.append(newFamilyMember)
        guard let data = try? JSONEncoder().encode(family) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchFamily() -> [Family] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        guard let family = try? JSONDecoder().decode([Family].self, from: data) else { return [] }
        return family
    }
    
    func deleteContant(at index: Int) {
        var family = fetchFamily()
        family.remove(at: index)
        guard let data = try? JSONEncoder().encode(family) else { return }
        userDefaults.set(data, forKey: key)
    }
}
