//
//  EventModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import Foundation

struct Event: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let date: Date
    let address: String
    let category: EventCategory
    let imageURL: String?
}

enum EventCategory: String, CaseIterable {
    case music = "Music"
    case art = "Art"
    case technology = "Technology"
    case food = "Food"
    case literature = "Literature"
    case cinema = "Cinema"
    case sport = "Sport"

    var id: String { rawValue }
}
