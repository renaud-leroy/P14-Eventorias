//
//  FormField.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct FormField: View {
    
    let label: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.customColorTextForm)
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.customWhite))
                .foregroundColor(.customWhite)
        }
        .padding()
        .background(Color.customGrey)
        .cornerRadius(4)
    }
}

#Preview("FormField") {
    ZStack {
        Color.customColorBackground.ignoresSafeArea()
        FormField(label: "Title", placeholder: "New event", text: .init(get: {""}, set: {_ in}))
            .padding()
    }
}
