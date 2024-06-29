//
//  LoginViewModelTests.swift
//  TimetonicChallengeTests
//
//  Created by Tatiana Carvajal on 28/06/24.
//

import XCTest
@testable import TimetonicChallenge

final class LoginViewModelTests: XCTestCase {
    func testLoginSuccess() async {
        let loginViewModel = LoginViewModel(service: AuthServiceRepositoryMock())
        
        await loginViewModel.login()
        
        switch loginViewModel.state {
        case .success(let response):
            XCTAssertEqual(response, .init(sessKey: "sesskey"))
        default: XCTFail("This shouldn't happen because the mock has a default success")
        }
    }
    
    func testLoginFailure() async {
        let authServiceRepositoryMock = AuthServiceRepositoryMock()
        authServiceRepositoryMock.shouldSessKeyWork = false
        let loginViewModel = LoginViewModel(service: authServiceRepositoryMock)
        
        await loginViewModel.login()
        
        switch loginViewModel.state {
        case .error(let error):
            XCTAssertTrue(true)
        default: XCTFail("This shouldn't happen because the mock should always fail")
        }
    }
}
