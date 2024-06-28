//
//  LoginViewModel.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    let service: AuthServiceRepository
    
    init(service: AuthServiceRepository) {
        self.service = service
    }
    
    func login() async {
        do {
            let appKeyResponse = try await service.createAppKey()
            try await service.createOauthKey(email: "demo", password: "test", appkey: appKeyResponse.appkey)
        }
        catch {
            print("error")
        }
    }
}
