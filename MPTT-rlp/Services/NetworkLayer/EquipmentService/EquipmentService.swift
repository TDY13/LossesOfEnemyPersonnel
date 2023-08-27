//
//  EquipmentService.swift
//  MPTT-rlp
//
//  Created by DiOS on 27.08.2023.
//

import Foundation

final class EquipmentService {
    private var lossesEquipments : LossesEquipment = []
    private var lossesEquipmentCorrection : LossesEquipmentCorrection = []

    private var networkLayer: NetworkLayer
    
    // MARK: - Functions
    init(networkLayer: NetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func takeLossesEquipment() async throws -> [LossesEquipmentModel] {
        let equipmentData = try await networkLayer.fetchDataAsync(from: R.URL.equipmentURL.setupURL(), modelType: LossesEquipmentModel.self)
        
        self.lossesEquipments = equipmentData
        try await getAllEquipmentCorrection()

        return self.lossesEquipments
    }
    
    private func getAllEquipmentCorrection() async throws {
        do {
            let equipmentCorrection = try await networkLayer.fetchDataAsync(from: R.URL.equipmentCorrectionURL.setupURL(), modelType: LossesEquipmentCorrectionModel.self)
            self.lossesEquipmentCorrection = equipmentCorrection

            self.updateMergedEquipment()
        } catch {
            throw error
        }
    }

    private func updateMergedEquipment() {
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
    
    func createEquipmentDataFromReflection(_ lossesEquipment: LossesEquipmentModel) -> [EquipmentModel] {
        let mirror = Mirror(reflecting: lossesEquipment)
        return mirror.children.compactMap { child in
            guard let label = child.label else {
                return nil
            }
            
            if label == R.constant.date || label == R.constant.day || label == R.constant.id {
                return nil
            }
            
            let words = label.split(separator: " ").map { String($0) }
            let fieldName = words
                .map { word in
                    return word.prefix(1).uppercased() + word.dropFirst()
                }
                .joined(separator: " ")
            
            if let value = child.value as? Any? {
                if let unwrappedValue = value {
                    return EquipmentModel(name: fieldName, value: unwrappedValue)
                }
            }
            return nil
        }
    }
}

