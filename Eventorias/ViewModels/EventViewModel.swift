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
    private var alreadyLoaded = false
    
    init(repository: EventRepositoryProtocol) {
        self.repository = repository
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
    
    func loadEventsIfNeeded() async {
        guard !alreadyLoaded else { return }
        alreadyLoaded = true
        await loadEvents()
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
        isLoading = true

        let eventId = UUID()
        var imageURL: String?

        do {
            if let image {
                imageURL = try await repository.uploadImage(image, eventId: eventId)
            }

            let event = Event(
                id: eventId,
                title: title,
                description: description,
                date: date,
                address: address,
                category: category,
                imageURL: imageURL
            )

            try await repository.createEvent(event, image: nil)

            eventsList.append(event)
            applyFilter(query: query)

            NotificationService.shared.eventReminder(
                title: event.title,
                date: event.date
            )
        } catch {
            errorMessage = "Failed to create event"
            throw error
        }
        isLoading = false
    }
}
