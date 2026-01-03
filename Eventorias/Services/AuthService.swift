//
//  AuthService.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws
    func signOut() throws
    func createUser(email: String, password: String) async throws 
}

final class AuthService: AuthServiceProtocol {
        
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func createUser(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
}
