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
    let isSecureTextEntry: Bool
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.customColorTextForm)
            if isSecureTextEntry {
                SecureField("",
                            text: $text,
                            prompt: Text(placeholder).foregroundColor(.customWhite))
            } else {
                TextField("",
                          text: $text,
                          prompt: Text(placeholder).foregroundColor(.customWhite))
            }
        }
        .padding()
        .background(Color.customGrey)
        .cornerRadius(4)
        .foregroundColor(.customWhite)
    }
}

#Preview("FormField") {
    ZStack {
        Color.customColorBackground.ignoresSafeArea()
        FormField(label: "Title", placeholder: "New event", isSecureTextEntry: false, text: .init(get: {""}, set: {_ in}))
            .padding()
    }
}
