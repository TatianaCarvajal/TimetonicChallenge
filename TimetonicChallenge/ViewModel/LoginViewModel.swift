//
//  LoginViewModel.swift
//  TimetonicChallenge
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    enum State: Equatable {
        case loading
        case error(ServiceError)
        case idle
        case success(SessKeyResponse)
        
        var sessionKey: String? {
            if case let .success(value) = self {
                return value.sessKey
            } else { return nil }
        }
    }
    
    @Published var email = ""
    @Published var password = ""
    @Published var state = State.idle
    @Published var isShowingError = false
    @Published var shouldGoToBookList: Bool = false
    
    let service: AuthServiceRepository
    
    init(service: AuthServiceRepository) {
        self.service = service
    }
    
    func login() async {
        state = .loading
        do {
            let appKeyResponse = try await service.createAppKey()
            let oauthResponse = try await service.createOauthKey(email: email, password: password, appkey: appKeyResponse.appkey)
            let sessKeyResponse = try await service.createSessKey(oauthUser: oauthResponse.oAuthUser, oauthKey: oauthResponse.oAuthKey)
            state = .success(sessKeyResponse)
        }
        catch {
            state = .error(.urlDoesNotExist)
        }
    }
}
