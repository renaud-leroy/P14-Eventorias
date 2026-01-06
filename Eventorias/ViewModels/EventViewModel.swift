//
//  EventViewModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import Foundation
import Observation
import UIKit
import FirebaseStorage

@MainActor
@Observable
final class EventViewModel {
    
    private let repository: EventRepositoryProtocol
    
    var eventsList : [Event] = []
    var filteredEventsList : [Event] = []
    var query: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    
    init() {
        self.repository = EventRepository()
    }
  
    func loadEvents() async {
        isLoading = true
        errorMessage = nil
        do {
            eventsList = try await repository.fetchEvents()
        } catch {
            self.errorMessage = "Failed to load events"
        }
        isLoading = false
    }
    
    func applyFilter(query: String, category: EventCategory? = nil, date: Date? = nil) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        filteredEventsList = eventsList.filter { event in
            let matchesQuery =
                trimmedQuery.isEmpty ||
                event.title.localizedCaseInsensitiveContains(trimmedQuery)

            let matchesCategory =
                category == nil || event.category == category

            let matchesDate =
                date == nil ||
                Calendar.current.isDate(event.date, inSameDayAs: date!)

            return matchesQuery && matchesCategory && matchesDate
        }
    }
    
    func createEvent(title: String, description: String, date: Date, address: String, category: EventCategory, image: UIImage?) async throws {
        let event = Event(
            id: UUID(),
            title: title,
            description: description,
            date: date,
            address: address,
            category: category,
            imageURL: nil
        )

        try await repository.createEvent(event, image: image)

        eventsList.append(event)
        applyFilter(query: query)
    }
}
