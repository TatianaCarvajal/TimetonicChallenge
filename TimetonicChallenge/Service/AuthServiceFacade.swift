//
//  AuthServiceFacade.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

class AuthServiceFacade: AuthServiceRepository {
    func createAppKey() async throws -> AppKeyResponse {
        guard let url = URL(string: "https://timetonic.com/live/api.php") else {
            throw ServiceError.urlDoesNotExist
        }
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = HttpMethod.post.rawValue
        let parameters = "req=createAppkey&version=6.49q%2F6.49&appname=api"
        let postData =  parameters.data(using: .utf8)
        requestUrl.httpBody = postData
        let (data, _) = try await URLSession.shared.data(for: requestUrl)
        let decoder = JSONDecoder()
        let str = String(data: data, encoding: .utf8)
        do {
            let result = try decoder.decode(AppKeyResponse.self, from: data)
            return result
        }
        catch {
            let error = try decoder.decode(ErrorResponse.self, from: data)
            throw ServiceError.serviceFailed(error)
        }
    }
}
