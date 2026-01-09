//
//  ProfileViewModelTests.swift
//  EventoriasTests
//
//  Created by Renaud Leroy on 09/01/2026.
//

import XCTest
@testable import Eventorias

@MainActor
final class ProfileViewModelTests: XCTestCase {

    private var service: MockProfileService!
    private var viewModel: ProfileViewModel!

    override func setUp() {
        super.setUp()
        service = MockProfileService()
        viewModel = ProfileViewModel(profileService: service)
    }

    override func tearDown() {
        service = nil
        viewModel = nil
        super.tearDown()
    }

    func test_updateProfileImage_success_updatesImageAndCallsService() async {
        // GIVEN
        let image = UIImage(systemName: "person.circle")!
        service.returnedURL = URL(string: "https://test.com/avatar.jpg")

        // WHEN
        await viewModel.updateProfileImage(image)

        // THEN
        XCTAssertTrue(service.didUploadImage)
        XCTAssertTrue(service.didUpdateProfile)
        XCTAssertEqual(viewModel.profileImage, image)
    }

    func test_updateProfileImage_failure_doesNotUpdateProfile() async {
        // GIVEN
        let image = UIImage(systemName: "person.circle")!
        service.returnedURL = nil

        // WHEN
        await viewModel.updateProfileImage(image)

        // THEN
        XCTAssertTrue(service.didUploadImage)
        XCTAssertFalse(service.didUpdateProfile)
        XCTAssertNil(viewModel.profileImage)
    }

    func test_toggleNotification_changesState() {
        // WHEN
        viewModel.isNotificationOn.toggle()

        // THEN
        XCTAssertTrue(viewModel.isNotificationOn)
    }

    func test_togglePhotoPicker_changesState() {
        // WHEN
        viewModel.showPhotoPicker.toggle()

        // THEN
        XCTAssertTrue(viewModel.showPhotoPicker)
    }
}
