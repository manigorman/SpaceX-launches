//
//  Settings.swift
//  Launches
//
//  Created by Igor Manakov on 15.04.2022.
//

import Foundation

//enum LengthUnit: String, Codable {
//    case m
//    case ft
//}
//
//enum MassUnit: String, Codable {
//    case kg
//    case lb
//}

enum LengthUnit: Int, Codable, CaseIterable {
    case m = 0, ft = 1
    
    var description: String {
        switch self {
        case .m:      return "m"
        case .ft:  return "ft"
        }
    }
}

enum MassUnit: Int, Codable, CaseIterable {
    case kg = 0, lb = 1
    
    var description: String {
        switch self {
        case .kg:      return "kg"
        case .lb:  return "lb"
        }
    }
}

struct UserSettings: Codable {
    var height: LengthUnit
    var diameter: LengthUnit
    var mass: MassUnit
    var payload: MassUnit
}
