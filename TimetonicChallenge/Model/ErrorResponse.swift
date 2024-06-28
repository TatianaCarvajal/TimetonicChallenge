//
//  ErrorResponse.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct ErrorResponse: Codable {
    var errorMessage: String
    var errorCode: String
    
    enum Codingkeys: String, CodingKey {
        case errorMessage = "errorMsg"
        case errorCode
    }
}
