//
//  EventsNavigation.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct EventsNavigation: View {
    let EventVM: EventViewModel
    var body: some View {
        NavigationStack {
            EventListView(vm: EventVM)
        }
    }
}

