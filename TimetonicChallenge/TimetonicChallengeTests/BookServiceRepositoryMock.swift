//
//  BookServiceRepositoryMock.swift
//  TimetonicChallengeTests
//
//  Created by Tatiana Carvajal on 29/06/24.
//

import Foundation
@testable import TimetonicChallenge

class BookServiceRepositoryMock: BookServiceRepository {
    var shoulAllBooksWork = true
    
    func fetchAllBooks(oauthUser: String, user: String, sessKey: String) async throws -> TimetonicChallenge.BookListResponse {
        if shoulAllBooksWork == false {
            throw ServiceError.noDataFound
        } else {
            BookListResponse(
                allBooks: BookList(
                    contacts: [],
                    books: []
                )
            )
        }
    }
}
