//
//  UserSettings.swift
//  Launches
//
//  Created by Igor Manakov on 10.04.2022.
//

import Foundation

enum LengthUnit: String, CaseIterable {
    case m
    case ft
}

enum MassUnit: String, CaseIterable {
    case kg
    case lb
}

class RocketModel: NSObject, NSCoding {
    
    var height: LengthUnit
    var diameter: LengthUnit
    var mass: MassUnit
    var payload: MassUnit
    
    init(height: LengthUnit, diameter: LengthUnit, mass: MassUnit, payload: MassUnit) {
        self.height = height
        self.diameter = diameter
        self.mass = mass
        self.payload = payload
    }
    
    required init?(coder: NSCoder) {
        height = LengthUnit(rawValue: coder.decodeObject(forKey: "height") as! String) ?? .m
        diameter = LengthUnit(rawValue: coder.decodeObject(forKey: "diameter") as! String) ?? .m
        mass = MassUnit(rawValue: coder.decodeObject(forKey: "mass") as! String) ?? .kg
        payload = MassUnit(rawValue: coder.decodeObject(forKey: "payload") as! String) ?? .kg
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(height.rawValue, forKey: "height")
        coder.encode(diameter.rawValue, forKey: "diameter")
        coder.encode(mass.rawValue, forKey: "mass")
        coder.encode(payload.rawValue, forKey: "payload")
    }
}

final class UserSettings {
    private enum SettingsKeys: String {
        case RocketModel
    }
    
    static var rocketModel: RocketModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.RocketModel.rawValue) as? Data,
                  let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? RocketModel else {
                return nil
            }
            return decodedModel
        } set {
            let defaults = UserDefaults.standard
            
            let key = SettingsKeys.RocketModel.rawValue
            
            if let rocketModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: rocketModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
}
