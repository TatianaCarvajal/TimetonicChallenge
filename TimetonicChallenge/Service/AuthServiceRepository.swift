//
//  AuthService.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

protocol AuthServiceRepository {
    func createAppKey() async throws -> AppKeyResponse
}
