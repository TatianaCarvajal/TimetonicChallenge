//
//  LoginViewModel.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    enum State {
        case loading
        case error(ServiceError)
        case idle
        case success(SessKeyResponse)
    }
    
    let service: AuthServiceRepository
    var state = State.idle
    
    init(service: AuthServiceRepository) {
        self.service = service
    }
    
    func login() async {
        state = .loading
        do {
            let appKeyResponse = try await service.createAppKey()
            let oauthResponse = try await service.createOauthKey(email: "demo", password: "test", appkey: appKeyResponse.appkey)
            let sessKeyResponse = try await service.createSessKey(oauthUser: oauthResponse.oAuthUser, oauthKey: oauthResponse.oAuthKey)
            state = .success(sessKeyResponse)
        }
        catch {
            state = .error(.urlDoesNotExist)
        }
    }
}
