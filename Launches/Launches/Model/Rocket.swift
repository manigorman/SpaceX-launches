//
//  Rocket.swift
//  Launches
//
//  Created by Igor Manakov on 07.04.2022.
//

import Foundation

struct Rocket: Codable {
    
    let height: Length
    let diameter: Length
    let mass: Weight
    let payload_weights: [Weight]
    
    let name: String
    
    let first_flight: String
    let country: String
    let cost_per_launch: Double
    
    let first_stage: Stage
    let second_stage: Stage
    
    let flickr_images: [String]
}

struct Length: Codable {
    let meters: Double
    let feet: Double
}

struct Weight: Codable {
    let kg: Double
    let lb: Double
}

struct Stage: Codable {
    let engines: Int?
    let fuel_amount_tons: Double?
    let burn_time_sec: Int?
}
