//
//  BookServiceRepository.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

protocol BookServiceRepository {
    func fetchAllBooks(oauthUser: String, user: String, sessKey: String) async throws -> BookListResponse
}
