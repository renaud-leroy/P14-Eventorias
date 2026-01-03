//
//  AuthViewModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class AuthViewModel {
    var isAuthenticated: Bool = false
    var errorMessage: String?
    var confirmPassword: String = ""
    
    var authService: AuthServiceProtocol
    
    init(isAuthenticated: Bool, errorMessage: String? = nil, authService: AuthServiceProtocol) {
        self.isAuthenticated = isAuthenticated
        self.errorMessage = errorMessage
        self.authService = authService
    }
    
    func login(email: String, password: String) async {
        do {
            try await authService.signIn(email: email, password: password)
            isAuthenticated = true
            errorMessage = nil
        } catch {
            isAuthenticated = false
            errorMessage = "Connection failed"
        }
    }
    
    func signOut() {
        do {
            try authService.signOut()
            isAuthenticated = false
        } catch {
            errorMessage = "Sign out failed"
        }
    }
    
    func register(email: String, password: String) async {
        do {
            guard verifyPassword(password: password, confirmPassword: confirmPassword) else {
                return
            }
            
            try await authService.createUser(email: email, password: password)
            isAuthenticated = true
        } catch {
            errorMessage = "Registration failed"
        }
    }
    
    func verifyPassword(password: String, confirmPassword: String) -> Bool {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }
        errorMessage = nil
        return true
    }
}
