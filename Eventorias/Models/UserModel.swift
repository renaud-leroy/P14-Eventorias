//
//  UserModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import Foundation

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let token: String
}
