//
//  CreateEventView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI
import PhotosUI

struct CreateEventView: View {
    
    let vm: EventViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var eventDate: Date = .now
    @State private var address = ""
    @State private var category: EventCategory = .music
    @State private var text: String = ""
    @State private var showingCamera = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.customColorBackground.ignoresSafeArea()
            VStack(spacing: 26) {
                FormField(label: "Title", placeholder: "New Event", isSecureTextEntry: false, text: $title)
                FormField(label: "Description", placeholder: "Tap here to enter your description", isSecureTextEntry: false, text: $description)
                HStack {
                    DateFormField(label: "Date", date: $eventDate)
                        .environment(\.colorScheme, .dark)
                    TimeFormField(label: "Time", date: $eventDate)
                        .environment(\.colorScheme, .dark)
                }
                FormField(label: "Address", placeholder: "Enter full address", isSecureTextEntry: false, text: $address)
                HStack(spacing: 18) {
                    Button {
                        showingCamera = true
                    } label: {
                        CameraButton()
                    }
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                        PickerButton()
                    }
                }
                .padding(16)
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                }
                Spacer()
                Button {
                    Task {
                        do {
                            try await vm.createEvent(title: title, description: description, date: eventDate, address: address, category: category, image: selectedImage)
                            dismiss()
                        } catch {
                            print("erreur de creation")
                        }
                    }
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
            .sheet(isPresented: $showingCamera) {
                CameraView(image: $selectedImage)
            }
            .onChange(of: selectedItem) { _, newItem in
                if let newItem = newItem {
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            selectedImage = image
                        }
                    }
                }
            }
        }
    }
}

struct CameraButton: View {
    var body: some View {
        Image(systemName: "camera")
            .frame(width: 55, height: 55)
            .foregroundStyle(Color.primary)
            .background(Color.white)
            .cornerRadius(16)
    }
}

struct DateFormField: View {
    let label: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.customColorTextForm)
                .padding(.trailing, 120)
            DatePicker(
                "",
                selection: $date,
                displayedComponents: [.date]
            )
            .labelsHidden()
        }
        .padding(.vertical, 10)
        .frame(maxWidth: 300)
        .background(Color.customGrey)
        .cornerRadius(4)
        .foregroundColor(.customWhite)
    }
}

struct TimeFormField: View {
    let label: String
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.customColorTextForm)
                .padding(.trailing, 120)
            DatePicker(
                "",
                selection: $date,
                displayedComponents: [.hourAndMinute]
            )
            .labelsHidden()
        }
        .padding(.vertical, 10)
        .frame(maxWidth: 300)
        .background(Color.customGrey)
        .cornerRadius(4)
        .foregroundColor(.customWhite)
    }
}

struct PickerButton: View {
    var body: some View {
        Image(systemName: "paperclip")
            .frame(width: 55, height: 55)
            .foregroundStyle(Color.white)
            .background(Color.customRed)
            .cornerRadius(16)
    }
}

#Preview {
    CreateEventView(vm: EventViewModel())
}
