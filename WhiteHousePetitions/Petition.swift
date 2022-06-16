//
//  Petition.swift
//  WhiteHousePetitions
//
//  Created by Petruț Vinca on 15.06.2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
