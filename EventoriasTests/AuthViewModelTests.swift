//
//  AuthViewModelTests.swift
//  EventoriasTests
//
//  Created by Renaud Leroy on 09/01/2026.
//

import XCTest
@testable import Eventorias

@MainActor
final class AuthViewModelTests: XCTestCase {
    
    private var authService: MockAuthService!
    private var viewModel: AuthViewModel!
    
    override func setUp() {
        super.setUp()
        authService = MockAuthService()
        viewModel = AuthViewModel(
            isAuthenticated: false,
            authService: authService
        )
    }
    
    override func tearDown() {
        authService = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_login_success_returnIsAuthenticatedToTrue() async throws {
        // GIVEN
        authService.didSignIn = false
        
        // WHEN
        await viewModel.login(email: "test@test.com", password: "password")
        
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertTrue(authService.didSignIn)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_login_failure_returnsErrorMessage() async {
        // GIVEN
        authService.shouldFail = true
        
        // WHEN
        await viewModel.login(
            email: "test@mail.com",
            password: "wrong"
        )
        
        // THEN
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(authService.didSignIn)
    }
    
    func test_register_success_returnsAuthenticatedTrue() async {
        // GIVEN
        authService.shouldFail = false
        viewModel.confirmPassword = "123456"
        
        // WHEN
        await viewModel.register(
            email: "test@mail.com",
            password: "123456"
        )
        
        // THEN
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(authService.didRegister)
    }
    
    func test_register_passwordMismatch_returnsErrorMessage() async {
        // GIVEN
        viewModel.confirmPassword = "123456"

        // WHEN
        await viewModel.register(
            email: "test@mail.com",
            password: "654321"
        )

        // THEN
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertEqual(viewModel.errorMessage, "Passwords do not match")
        XCTAssertFalse(authService.didRegister)
    }
    
    func test_register_failure_returnsErrorMessage() async {
        // GIVEN
        authService.shouldFail = true
        viewModel.confirmPassword = "123456"

        // WHEN
        await viewModel.register(
            email: "test@mail.com",
            password: "123456"
        )

        // THEN
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(authService.didRegister)
    }
    
    func test_signOut_setsAuthenticatedFalse() {
        // GIVEN
        viewModel.isAuthenticated = true

        // WHEN
        viewModel.signOut()

        // THEN
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertTrue(authService.didSignOut)
    }
    
    func test_verifyPassword_matchingPasswords_returnsTrue() {
        // WHEN
        let result = viewModel.verifyPassword(
            password: "123",
            confirmPassword: "123"
        )

        // THEN
        XCTAssertTrue(result)
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_verifyPassword_differentPasswords_returnsFalse() {
        // WHEN
        let result = viewModel.verifyPassword(
            password: "123",
            confirmPassword: "456"
        )

        // THEN
        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorMessage, "Passwords do not match")
    }
}
