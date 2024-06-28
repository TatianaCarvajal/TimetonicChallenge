//
//  SessKeyResponse.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct SessKeyResponse: Codable, Equatable {
    var sessKey: String
    
    enum CodingKeys: String, CodingKey {
        case sessKey = "sesskey"
    }
}
