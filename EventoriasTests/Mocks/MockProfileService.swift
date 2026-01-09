//
//  MockProfileService.swift
//  EventoriasTests
//
//  Created by Renaud Leroy on 09/01/2026.
//

import Foundation
import UIKit
@testable import Eventorias


final class MockProfileService: ProfileServiceProtocol {
    
    var userToReturn: ProfileUser?
    var imageToReturn: UIImage?
    
    
    var returnedURL: URL? = URL(string: "https://test.com/avatar.jpg")
    var didUploadImage = false
    var didUpdateProfile = false
    
    func fetchCurrentUser() async -> ProfileUser? {
        return userToReturn
    }
    
    func fetchProfileImage(from url: URL) async -> UIImage? {
        return imageToReturn
    }
    
    func uploadProfileImage(_ image: UIImage) async -> URL? {
        didUploadImage = true
        return returnedURL
    }
    
    func updateProfile(username: String, photoURL: URL?) {
        didUpdateProfile = true
    }
}


