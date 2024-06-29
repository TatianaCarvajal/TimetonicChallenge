//
//  OauthKeyResponse.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct OauthKeyResponse: Codable {
    var oAuthKey: String
    var oAuthUser: String
    
    enum CodingKeys: String, CodingKey {
        case oAuthKey = "oauthkey"
        case oAuthUser = "o_u"
    }
}
