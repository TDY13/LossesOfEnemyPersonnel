//
//  EquipmentService.swift
//  MPTT-rlp
//
//  Created by DiOS on 27.08.2023.
//

import Foundation

class EquipmentService {
    private var lossesEquipments : LossesEquipment = []
    private var lossesEquipmentCorrection : LossesEquipmentCorrection = []

    static let shared = EquipmentService()
    
    // MARK: - Functions
    private init() {}
    
    func takeLossesEquipment() async throws {
        do {
            let equipmentData = try await NetworkLayer.shared.fetchDataAsync(from: R.URL.equipmentURL.setupURL(), modelType: LossesEquipmentModel.self)
            self.lossesEquipments = equipmentData
            self.lossesEquipments.sort { $0.day > $1.day }

            try await getAllEquipmentCorrection()
        } catch {
            throw error
        }
    }
    
    func takeLossesEquipment() async throws -> [LossesEquipmentModel] {
        let equipmentData = try await NetworkLayer.shared.fetchDataAsync(from: R.URL.equipmentURL.setupURL(), modelType: LossesEquipmentModel.self)
        
        self.lossesEquipments = equipmentData
        try await getAllEquipmentCorrection()

        return self.lossesEquipments
    }
    
    func getAllEquipmentCorrection() async throws {
        do {
            let equipmentCorrection = try await NetworkLayer.shared.fetchDataAsync(from: R.URL.equipmentCorrectionURL.setupURL(), modelType: LossesEquipmentCorrectionModel.self)
            self.lossesEquipmentCorrection = equipmentCorrection

            self.updateMergedEquipment()
        } catch {
            throw error
        }
    }

    func updateMergedEquipment() {
        self.lossesEquipmentCorrection.forEach { mergeEquipment in
            if let index = self.lossesEquipments.firstIndex(where: { $0.day == mergeEquipment.day }) {
                let lossesEquipment = self.lossesEquipments[index]

                lossesEquipment.aircraft += mergeEquipment.aircraft
                lossesEquipment.tank += mergeEquipment.tank
                lossesEquipment.helicopter += mergeEquipment.helicopter
                lossesEquipment.apc += mergeEquipment.apc
                lossesEquipment.fieldArtillery += mergeEquipment.fieldArtillery
                lossesEquipment.mrl += mergeEquipment.mrl
                lossesEquipment.drone += mergeEquipment.drone
                lossesEquipment.navalShip += mergeEquipment.navalShip
                lossesEquipment.antiAircraftWarfare += mergeEquipment.antiAircraftWarfare

                if let specialEquipment = lossesEquipment.specialEquipment {
                    lossesEquipment.specialEquipment = specialEquipment + mergeEquipment.specialEquipment
                }

                if let vehiclesAndFuelTanks = lossesEquipment.vehiclesAndFuelTanks {
                    lossesEquipment.vehiclesAndFuelTanks = vehiclesAndFuelTanks + mergeEquipment.vehiclesAndFuelTanks
                }

                if let cruiseMissiles = lossesEquipment.cruiseMissiles {
                    lossesEquipment.cruiseMissiles = cruiseMissiles + mergeEquipment.cruiseMissiles
                }
            }
        }
    }
}

