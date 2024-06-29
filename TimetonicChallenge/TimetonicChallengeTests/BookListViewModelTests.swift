//
//  BookListViewModelTests.swift
//  TimetonicChallengeTests
//
//  Created by Tatiana Carvajal on 29/06/24.
//

import XCTest
@testable import TimetonicChallenge

final class BookListViewModelTests: XCTestCase {
    @MainActor
    func testFetchAllBooks() async {
        let bookListViewModel = BookListViewModel(service: BookServiceRepositoryMock(), user: "user")
        
        await bookListViewModel.fetchAllBooks()
        
        switch bookListViewModel.state {
        case .success(let response):
            XCTAssertEqual(response, .init(allBooks: BookList(contacts: [], books: [])))
        default: XCTFail("This shouldn't happen because the mock has a default success")
        }
    }
    
    @MainActor
    func testFetchAllBooksFailure() async {
        let bookServiceRepositoryMock = BookServiceRepositoryMock()
        bookServiceRepositoryMock.shoulAllBooksWork = false
        let bookListViewModel = BookListViewModel(service: bookServiceRepositoryMock, user: "user")
        
        await bookListViewModel.fetchAllBooks()
        
        switch bookListViewModel.state {
        case .error(let error):
            XCTAssertEqual(error, .noDataFound)
        default: XCTFail("This shouldn't happen because the mock should always fail")
        }
    }
}
