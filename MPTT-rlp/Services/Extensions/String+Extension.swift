//
//  String+Extension.swift
//  MPTT-rlp
//
//  Created by DiOS on 27.08.2023.
//

import Foundation

extension String {
    func splitCamelCase() -> String {
        return self
            .enumerated()
            .map { index, character in
                if index > 0 && character.isUppercase {
                    return " " + String(character)
                } else {
                    return String(character)
                }
            }
            .joined()
    }
    
    func decodeDateFromString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = R.constant.dateFormatterYMD
        
        if let date = dateFormatter.date(from: self) {
            let resultFormatter = DateFormatter()
            resultFormatter.dateFormat = R.constant.dateFormatterDMY
            return resultFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func setupURL() -> URL {
        guard let baseURL = URL(string: R.URL.baseURL) else { return URL(string: self) ?? URL(fileURLWithPath: "") }
        return baseURL.appendingPathComponent(self)
    }
}
