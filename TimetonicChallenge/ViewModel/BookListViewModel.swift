//
//  BookListViewModel.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

@MainActor
class BookListViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case error(ServiceError)
        case idle
        case success(BookListResponse)
        
        var bookList: BookList? {
            if case let .success(bookListResponse) = self {
                return bookListResponse.allBooks
            } else { return nil }
        }
    }
    
    @Published var state = State.idle
    @Published var isShowingError = false
    @Published var query: String = ""
    
    let service: BookServiceRepository
    let user: String
    
    init(service: BookServiceRepository, user: String) {
        self.service = service
        self.user = user
    }
    
    func fetchAllBooks() async {
        state = .loading
        do {
            guard let sessKey = UserDefaults.standard.value(forKey: "sessKey") as? String else {
                state = .error(.noDataFound)
                return
            }
            let booksResponse = try await service.fetchAllBooks(oauthUser: user, user: user, sessKey: sessKey)
            state = .success(booksResponse)
        }
        
        catch {
            if let serviceError = error as? ServiceError {
                state = .error(serviceError)
            } else {
                state = .error(.noDataFound)
                isShowingError = true
            }
        }
    }
}
