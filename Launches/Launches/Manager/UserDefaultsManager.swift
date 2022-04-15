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
    private static let userDefaults = UserDefaults.standard

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
                
                let result = try decoder.decode(UserSettings.self, from: data)
                
                completion(.success(result))
                
            } catch {
                print("Unable to Decode Data (\(error))")
            }
        }
    }
    
}
