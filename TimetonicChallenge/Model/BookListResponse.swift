//
//  BookListResponse.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct BookListResponse: Codable, Equatable {
    var allBooks: BookList
}

struct BookList: Codable, Equatable {
    var contacts: [Contact]
    var books: [Book]
}

struct Contact: Codable, Equatable {
    var userContact: String
    
    enum CodingKeys: String, CodingKey {
        case userContact = "u_c"
    }
}

struct Book: Codable, Equatable, Identifiable {
    var id = UUID()
    var ownerPrefs: OwnerPreference
    
    enum CodingKeys: String, CodingKey {
        case ownerPrefs
    }
}

struct OwnerPreference: Codable, Equatable {
    var title: String
    var oCoverImg: String?
    
    var url: URL? {
        guard let oCoverImg else { return nil }
        return URL(string: "https://timetonic.com\(oCoverImg)")
    }
}
