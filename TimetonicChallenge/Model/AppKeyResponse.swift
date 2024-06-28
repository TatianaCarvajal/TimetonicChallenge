//
//  AppKeyResponse.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct AppKeyResponse: Codable {
    var appkey: String
}

struct AppKeyRequestBody: Codable {
    var req: String
    var version: String
    var appname: String
    
}
