//
//  BookServiceFacade.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

struct BookServiceFacade: BookServiceRepository {
    func fetchAllBooks(oauthUser: String, user: String, sessKey: String) async throws -> BookListResponse {
        guard let url = URL(string: "https://timetonic.com/live/api.php") else {
            throw ServiceError.urlDoesNotExist
        }
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = HttpMethod.post.rawValue
        let parameters = "req=getAllBooks&o_u=\(oauthUser)&u_c=\(user)&sesskey=\(sessKey)"
        let postData =  parameters.data(using: .utf8)
        requestUrl.httpBody = postData
        let (data, _) = try await URLSession.shared.data(for: requestUrl)
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(BookListResponse.self, from: data)
            return result
        }
        catch {
            let error = try decoder.decode(ErrorResponse.self, from: data)
            throw ServiceError.serviceFailed(error)
        }
    }
}
