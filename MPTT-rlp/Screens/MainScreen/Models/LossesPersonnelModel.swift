//
//  LossesPersonnelModel.swift
//  MPTT-rlp
//
//  Created by DiOS on 21.08.2023.
//

import Foundation

struct LossesPersonnelModel: Codable, Hashable {
    let date: String
    let day, personnel: Int
    let lossesPersonnel: Personnel
    let pow: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case lossesPersonnel = "personnel*"
        case pow = "POW"
    }
}

enum Personnel: String, Codable {
    case about = "about"
    case more = "more"
}

