//
//  AuthServiceRepositoryMock.swift
//  TimetonicChallengeTests
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation
@testable import TimetonicChallenge

class AuthServiceRepositoryMock: AuthServiceRepository {
    var shouldCreateAppKeyWork = true
    var shouldOAuthKeyWork = true
    var shouldSessKeyWork = true
    
    func createAppKey() async throws -> TimetonicChallenge.AppKeyResponse {
        if shouldCreateAppKeyWork == false {
            throw ServiceError.urlDoesNotExist
        } else {
            return AppKeyResponse(appkey: "appKey")
        }
    }
    
    func createOauthKey(email: String, password: String, appkey: String) async throws -> TimetonicChallenge.OauthKeyResponse {
        if shouldOAuthKeyWork == false {
            throw ServiceError.noDataFound
        } else {
            return OauthKeyResponse(oAuthKey: "oauthKey", oAuthUser: "oauthUser")
        }
    }
    
    func createSessKey(oauthUser: String, oauthKey: String) async throws -> TimetonicChallenge.SessKeyResponse {
        if shouldSessKeyWork == false {
            throw ServiceError.noDataFound
        } else {
            return SessKeyResponse(sessKey: "sesskey")
        }
    }
}
