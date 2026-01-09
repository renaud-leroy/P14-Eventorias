//
//  MockAuthService.swift
//  EventoriasTests
//
//  Created by Renaud Leroy on 09/01/2026.
//

import Foundation
@testable import Eventorias

final class MockAuthService: AuthServiceProtocol {

    var shouldFail = false
    var didSignIn = false
    var didRegister = false
    var didSignOut = false

    func signIn(email: String, password: String) async throws {
        if shouldFail {
            throw MockAuthError.signInFailed
        }
        didSignIn = true
    }

    func createUser(email: String, password: String) async throws {
        if shouldFail {
            throw MockAuthError.registerFailed
        }
        didRegister = true
    }

    func signOut() throws {
        if shouldFail {
            throw MockAuthError.signOutFailed
        }
        didSignOut = true
    }
    
    enum MockAuthError: Error {
        case signInFailed
        case registerFailed
        case signOutFailed
    }
}
