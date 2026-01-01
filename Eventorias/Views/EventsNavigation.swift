//
//  EventsNavigation.swift
//  Eventorias
//
//  Created by Renaud Leroy on 01/01/2026.
//

import SwiftUI

struct EventsNavigation: View {
    let vm: EventViewModel
    var body: some View {
        NavigationStack {
            EventListView(vm: vm)
        }
    }
}

#Preview {
    EventsNavigation(vm: EventViewModel())
}
