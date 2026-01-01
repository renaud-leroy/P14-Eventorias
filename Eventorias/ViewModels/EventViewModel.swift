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
    
    init() {
        self.eventsList = MockEvents.events
    }
}
