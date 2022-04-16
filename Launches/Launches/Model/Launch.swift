//
//  Launch.swift
//  Launches
//
//  Created by Igor Manakov on 15.04.2022.
//

import Foundation

struct Launch: Codable {
    
    let name: String?
    let success: Bool?
    let date_unix: Double?
    let rocket: String?
    let webcast: String?
}
