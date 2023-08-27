//
//  LossesEquipmentModel.swift
//  MPTT-rlp
//
//  Created by DiOS on 21.08.2023.
//

import Foundation

typealias LossesEquipment = [LossesEquipmentModel]

final class LossesEquipmentModel: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let date: String
    var day, aircraft, helicopter, tank: Int
    var apc, fieldArtillery, mrl: Int
    var militaryAuto, fuelTank: Int?
    var drone, navalShip, antiAircraftWarfare: Int
    var specialEquipment, mobileSRBMSystem: Int?
    var greatestLossesDirection: String?
    var vehiclesAndFuelTanks, cruiseMissiles: Int?
    
// MARK: - CodingKey
    enum CodingKeys: String, CodingKey, CaseIterable {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case greatestLossesDirection = "greatest losses direction"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
    
    static func == (lhs: LossesEquipmentModel, rhs: LossesEquipmentModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias LossesEquipmentCorrection = [LossesEquipmentCorrectionModel]

final class LossesEquipmentCorrectionModel: Codable {
    
    let date: String
    let day, aircraft, helicopter, tank: Int
    let apc, fieldArtillery, mrl, drone: Int
    let navalShip, antiAircraftWarfare, specialEquipment, vehiclesAndFuelTanks: Int
    let cruiseMissiles: Int

// MARK: - CodingKey
    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
}

struct EquipmentModel {
    let name: String
    let value: Any?
}
