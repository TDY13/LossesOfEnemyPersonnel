//
//  Resources.swift
//  MPTT-rlp
//
//  Created by DiOS on 21.08.2023.
//

import UIKit

struct R {
    
    struct color {
        static let bg = UIColor(hexString: "F8F8F8")
        static let black = UIColor(hexString: "0B0B0B")
        static let field = UIColor(hexString: "E9E9E9")
        static let silver = UIColor(hexString: "A8A8A8")
    }
    
    struct image {
        static let afou = "AFoU"
    }
    
    struct constant {
        static let id = "id"
        static let day = "day"
        static let date = "date"
        
        static let pow = "POW"
        static let unknownPOW = "POW - ?"
        static let averageOrcLosses = "Average Orc losses per day"
        
        static let dateFormatterYMD = "yyyy.MM.dd"
        static let dateFormatterDMY = "dd.MM.yyyy"
        
        static let lossesPersonnel = "Losses personnel"
        
        static let equipJSON = "lossesEquipment.json"
        static let onboardingJSON = "onboarding.json"
        static let personnelJSON = "lossesPersonnel.json"
        
        static let enemyLosses = "ENEMY LOSSES AMOUNTED TO:"
        static let info = "THE GENERAL STAFF OF THE AF of UKRAINE INFORMS"
    }
    
    struct URL {
        static let baseURL = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/"
        static let united24URL = "https://u24.gov.ua"
        static let personnelURL = "russia_losses_personnel.json"
        static let equipmentURL = "russia_losses_equipment.json"
        static let equipmentCorrectionURL = "russia_losses_equipment_correction.json"
    }
}


