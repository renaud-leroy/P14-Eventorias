//
//  EventViewModel.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class EventViewModel {
    var eventsList : [Event] = []
    var filteredEventsList : [Event] = []
    var query: String = ""
    
    init() {
        self.eventsList = MockEvents.events
        self.filteredEventsList = MockEvents.events
    }
  
    func filterEvents(for title: String, query: String) -> [Event] {
        eventsList.filter { event in
            event.title == title &&
            (query.isEmpty ||
             event.title.localizedCaseInsensitiveContains(query))
        }
    }
}
