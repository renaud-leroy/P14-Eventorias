//
//  CreateEventView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct CreateEventView: View {
    
    @State private var title = ""
    @State private var description = ""
    @State private var date = ""
    @State private var time = ""
    @State private var address = ""
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customColorBackground.ignoresSafeArea()
                VStack(spacing: 26) {
                    FormField(label: "Title", placeholder: "New Event", isSecureTextEntry: false, text: $title)
                    FormField(label: "Description", placeholder: "Tap here to enter your description", isSecureTextEntry: false, text: $description)
                    HStack(spacing: 18) {
                        FormField(label: "Date", placeholder: "MM/DD/YYYY", isSecureTextEntry: false, text: $date)
                        FormField(label: "Time", placeholder: "HH : MM", isSecureTextEntry: false, text: $time)
                    }
                    FormField(label: "Address", placeholder: "Enter full address", isSecureTextEntry: false, text: $address)
                    HStack(spacing: 18) {
                        CameraButton()
                        PaperclipButton()
                    }
                    .padding(16)
                    Spacer()
                    Button {
                        // action de validation
                    } label: {
                        Text("Validate")
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.customRed)
                            .cornerRadius(4)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(Text("Creation of an event"))
    }
}

struct CameraButton: View {
    var body: some View {
        Image(systemName: "camera")
            .frame(width: 55, height: 55)
            .background(Color.white)
            .cornerRadius(16)
    }
}

struct PaperclipButton: View {
    var body: some View {
        Image(systemName: "paperclip")
            .frame(width: 55, height: 55)
            .background(Color.customRed)
            .cornerRadius(16)
    }
}

#Preview {
    CreateEventView()
}
