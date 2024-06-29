//
//  ErrorResponse.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct ErrorResponse: Codable, Equatable {
    var errorMessage: String
    var errorCode: String
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "errorMsg"
        case errorCode
    }
}
