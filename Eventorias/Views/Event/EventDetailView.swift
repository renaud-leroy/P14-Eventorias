//
//  EventDetailView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    let event: Event
    @State private var coordinate: CLLocationCoordinate2D?
    
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                eventImage
                dateTimeSection
                Text(event.description)
                    .font(.subheadline)
                    .accessibilityLabel("Description : \(event.description)")
                locationSection
            }
            .padding()
        }
        .navigationTitle(event.title)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbarColorScheme(ColorScheme.dark)
        .background(Color(.customColorBackground))
        .foregroundStyle(Color(.customWhite))
        .task {
            await geocodeAddress()
        }
    }

    @ViewBuilder
    private var eventImage: some View {
        if let imageURL = event.imageURL,
           let url = URL(string: imageURL) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 360, height: 360)
            .clipped()
            .cornerRadius(14)
            .accessibilityHidden(true)
        } else {
            Color.gray.opacity(0.3)
                .frame(width: 360, height: 360)
                .cornerRadius(14)
                .accessibilityHidden(true)
        }
    }

    private var dateTimeSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "calendar")
                    Text(event.date, style: .date)
                }
                HStack {
                    Image(systemName: "clock")
                    Text(event.date, style: .time)
                }
            }
            .font(.headline)
            Spacer()
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .accessibilityHidden(true)
        }
        .font(.subheadline)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            "Date et heure : \(event.date)"
        )
    }

    private var locationSection: some View {
        HStack {
            // Adresse textuelle
            Text(event.address)
                .font(.headline)
                .frame(maxWidth: 170, maxHeight: 70)
                .accessibilityLabel("Adresse : \(event.address)")
            Spacer()
            if let coordinate {
                Map(
                    initialPosition: .region(
                        MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    ), interactionModes: []
                ) {
                    Marker(event.title, coordinate: coordinate)
                        .tint(.red)
                }
                .frame(maxWidth: 150, maxHeight: 70)
                .cornerRadius(12)
                .accessibilityHidden(true)
            } else {
                Color.gray.opacity(0.3)
                    .frame(maxWidth: 150, maxHeight: 70)
                    .cornerRadius(12)
                    .accessibilityHidden(true)
            }
        }
    }

    private func geocodeAddress() async {
        guard let request = MKGeocodingRequest(addressString: event.address) else { return }
        do {
            let mapItems = try await request.mapItems
            if let mapItem = mapItems.first {
                coordinate = mapItem.location.coordinate
            }
        } catch {
        }
    }
}
