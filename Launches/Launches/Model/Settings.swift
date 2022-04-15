//
//  Settings.swift
//  Launches
//
//  Created by Igor Manakov on 15.04.2022.
//

import Foundation

enum LengthUnit: String, Codable {
    case m
    case ft
}

enum MassUnit: String, Codable {
    case kg
    case lb
}

struct UserSettings: Codable {
    var height: LengthUnit
    var diameter: LengthUnit
    var mass: MassUnit
    var payload: MassUnit
}

var units: [String: Any] = ["Высота": LengthUnit.m, "Диаметр": LengthUnit.m, "Масса": MassUnit.kg, "Полезная нагрузка": MassUnit.kg]
