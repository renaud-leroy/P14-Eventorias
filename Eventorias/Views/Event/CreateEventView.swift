//
//  CreateEventView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI
import PhotosUI

struct CreateEventView: View {

    @Bindable var vm: EventViewModel
    @State private var title = ""
    @State private var description = ""
    @State private var eventDate: Date = .now
    @State private var address = ""
    @State private var category: EventCategory = .music
    @State private var showingCamera = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @Environment(\.dismiss) var dismiss

    private var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !description.trimmingCharacters(in: .whitespaces).isEmpty &&
        !address.trimmingCharacters(in: .whitespaces).isEmpty
    }
  
    
    var body: some View {
        ZStack {
            Color.customColorBackground.ignoresSafeArea()
            VStack(spacing: 14) {
                FormField(label: "Title", placeholder: "New Event", isSecureTextEntry: false, text: $title)
                    .accessibilityLabel("Titre de l'événement")
                    .accessibilityHint("Champ obligatoire")
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Créer un événement")
                FormField(label: "Description", placeholder: "Tap here to enter your description", isSecureTextEntry: false, text: $description)
                    .accessibilityLabel("Description de l'événement")
                    .accessibilityHint("Champ obligatoire")
                HStack {
                    DateFormField(label: "Date", date: $eventDate)
                        .environment(\.colorScheme, .dark)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Date de l'événement")
                    TimeFormField(label: "Time", date: $eventDate)
                        .environment(\.colorScheme, .dark)
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Heure de l'événement")
                }
                FormField(label: "Address", placeholder: "Enter full address", isSecureTextEntry: false, text: $address)
                    .accessibilityLabel("Adresse de l'événement")
                    .accessibilityHint("Champ obligatoire")
                HStack(spacing: 18) {
                    Button {
                        showingCamera = true
                    } label: {
                        CameraButton()
                    }
                    .accessibilityLabel("Prendre une photo avec la caméra")
                    PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()){
                        PickerButton()
                    }
                    .accessibilityLabel("Choisir une image depuis la photothèque")
                }
                .padding(14)
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                        .accessibilityHidden(true)
                }
                Spacer()
                Button {
                    Task {
                        do {
                            try await vm.createEvent(title: title, description: description, date: eventDate, address: address, category: category, image: selectedImage)
                            dismiss()
                        } catch {
                        }
                    }
                } label: {
                    Text("Validate")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(isFormValid ? Color.customRed : Color.gray)
                        .cornerRadius(4)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                .disabled(!isFormValid || vm.isLoading)
                .accessibilityLabel("Valider la création de l'événement")
                .accessibilityHint(
                    isFormValid
                    ? "Crée l'événement"
                    : "Veuillez remplir tous les champs obligatoires"
                )
            }
            .padding(.top, 40)
            .padding()
            .sheet(isPresented: $showingCamera) {
                CameraView(image: $selectedImage)
                    .ignoresSafeArea(edges: .all)
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
            if vm.isLoading {
                LoadingCreatingEventView()
            }
        }
        .animation(.easeInOut, value: vm.isLoading)
        .errorAlert(message: $vm.errorMessage)
    }
}

struct CameraButton: View {
    var body: some View {
        Image(systemName: "camera")
            .frame(width: 55, height: 55)
            .foregroundStyle(Color.black)
            .background(Color.white)
            .cornerRadius(16)
            .accessibilityHidden(true)
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
            .accessibilityHidden(true)
    }
}

#Preview {
    CreateEventView(vm: EventViewModel(repository: EventRepository()))
}
