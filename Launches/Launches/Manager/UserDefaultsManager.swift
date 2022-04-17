//
//  UserDefaultsManager.swift
//  Launches
//
//  Created by Igor Manakov on 15.04.2022.
//

import Foundation

extension UserDefaults {

    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    static let settingsKey = "Settings"
    
    public func isExist(for key: String) -> Bool {
        UserDefaults.standard.data(forKey: key) != nil
    }

    public func setData(with data: UserSettings, for key: String) -> Void {
        do {
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(data)
            
            UserDefaults.standard.set(data, forKey: key)
            
        } catch {
            print("Unable to Encode Data (\(error))")
        }
    }
    
    public func fetchData(with key: String, completion: @escaping (Result<UserSettings, Error>) -> Void) {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                
                let results = try decoder.decode(UserSettings.self, from: data)
                
                completion(.success(results))
                
            } catch {
                completion(.failure(error))
            }
        } else {
            print("Doesn't exist")
        }
    }
    
}
