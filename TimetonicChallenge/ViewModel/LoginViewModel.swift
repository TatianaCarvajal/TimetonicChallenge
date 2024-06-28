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
            try await service.createAppKey()
        }
        catch {
            print("error")
        }
    }
}
