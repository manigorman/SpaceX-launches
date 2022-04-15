//
//  APICaller.swift
//  Launches
//
//  Created by Igor Manakov on 07.04.2022.
//

import Foundation

struct Constants {
    static let rocketsAPIKey = "https://api.spacexdata.com/v4/rockets"
    static let launchesAPIKey = "https://api.spacexdata.com/v4/launches"
}

class APICaller {
    
    static let shared = APICaller()
    
    static var areRocketsUploaded = false
    
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        guard let url = URL(string: Constants.rocketsAPIKey) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode([Rocket].self, from: data)
                completion(.success(results))
                
                APICaller.areRocketsUploaded = true
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
