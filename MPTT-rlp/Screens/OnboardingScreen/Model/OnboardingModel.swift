//
//  OnboardingModel.swift
//  MPTT-rlp
//
//  Created by DiOS on 26.08.2023.
//

import Foundation

struct OnboardingModelSection: Decodable, Hashable {
    let items: [OnboardingModel]
}

struct OnboardingModel: Decodable, Hashable {
    let image: String
    let title: String
    let description: String
}
