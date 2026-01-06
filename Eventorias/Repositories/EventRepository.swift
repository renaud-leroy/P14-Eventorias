//
//  EventRepository.swift
//  Eventorias
//
//  Created by Renaud Leroy on 03/01/2026.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol EventRepositoryProtocol {
    func fetchEvents() async throws -> [Event]
    func createEvent(_ event: Event, image: UIImage?) async throws
    func uploadImage(_ image: UIImage, eventId: UUID) async throws -> String
}

final class EventRepository: EventRepositoryProtocol {
    
    private let firestoreDatabase = Firestore.firestore()
    
    func fetchEvents() async throws -> [Event] {
        let snapshot = try await firestoreDatabase
            .collection("events")
            .order(by: "date")
            .getDocuments()
        
        return snapshot.documents.compactMap { document -> Event? in
            let data = document.data()
            
            let imageURL = data["imageURL"] as? String
            
            guard
                let title = data["title"] as? String,
                let description = data["description"] as? String,
                let address = data["address"] as? String,
                let categoryRaw = data["category"] as? String,
                let timestamp = data["date"] as? Timestamp,
                let category = EventCategory(rawValue: categoryRaw)
            else {
                return nil
            }
            
            return Event(
                id: UUID(uuidString: document.documentID) ?? UUID(),
                title: title,
                description: description,
                date: timestamp.dateValue(),
                address: address,
                category: category,
                imageURL: imageURL
            )
        }
    }
    
    func uploadImage(_ image: UIImage, eventId: UUID) async throws -> String {
            guard let data = image.jpegData(compressionQuality: 0.8) else {
                throw URLError(.badURL)
            }

            let reference = Storage.storage()
                .reference()
                .child("events/\(eventId.uuidString).jpg")

            _ = try await reference.putDataAsync(data)
            let url = try await reference.downloadURL()

            return url.absoluteString
        }
    
    func createEvent(_ event: Event, image: UIImage?) async throws {

        var imageURL: String? = nil

        if let image {
            imageURL = try await uploadImage(image, eventId: event.id)
        }
        let data: [String: Any] = [
            "title": event.title,
            "description": event.description,
            "date": Timestamp(date: event.date),
            "address": event.address,
            "category": event.category.rawValue,
            "imageURL": imageURL ?? ""
        ]
        
        try await firestoreDatabase
            .collection("events")
            .document(event.id.uuidString)
            .setData(data)
    }
}
