//
//  MockEventRepository.swift
//  EventoriasTests
//
//  Created by Renaud Leroy on 09/01/2026.
//

import Foundation
@testable import Eventorias
import UIKit


final class MockEventRepository: EventRepositoryProtocol {
    func uploadImage(_ image: UIImage, eventId: UUID) async throws -> String {
        return "mock-url"
    }
    
    var eventsToReturn: [Event] = []
    var fetchCallCount = 0

    func fetchEvents() async throws -> [Event] {
        fetchCallCount += 1
        return eventsToReturn
    }

    func createEvent(_ event: Event, image: UIImage?) async throws {
        eventsToReturn.append(event)
    }
}
