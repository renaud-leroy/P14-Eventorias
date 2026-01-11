//
//  ErrorAlert.swift
//  Eventorias
//
//  Created by Renaud Leroy on 11/01/2026.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var errorMessage: String?
    
    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: .constant(errorMessage != nil)) {
                Button("OK") {
                    errorMessage = nil
                }
            } message: {
                Text(errorMessage ?? "")
            }
    }
}

extension View {
    func errorAlert(message: Binding<String?>) -> some View {
        modifier(ErrorAlertModifier(errorMessage: message))
    }
}

