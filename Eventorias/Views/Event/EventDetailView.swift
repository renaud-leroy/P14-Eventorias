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
    var body: some View {
        ZStack {
            Color(.customColorBackground)
                .ignoresSafeArea()
            VStack (spacing: 30) {
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
                } else {
                    Color.gray.opacity(0.3)
                        .frame(width: 360, height: 360)
                        .cornerRadius(14)
                }
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(event.date, style: .date)
                        }
                        HStack {
                            Image(systemName: "clock")
                            Text("16h - 20h")
                        }
                    }
                    .font(.headline)
                    Spacer()
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                }
                .font(.subheadline)
                Text(event.description)
                    .font(.subheadline)
                HStack {
                    Text(event.address)
                        .font(.headline)
                        .frame(maxWidth: 170, maxHeight: 70)
                    Spacer()
                    Map(
                        initialPosition: .region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: 48.864716,
                                    longitude: 2.349014
                                ),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.01,
                                    longitudeDelta: 0.01
                                )
                            )
                        ), interactionModes: []
                    )
                    .frame(maxWidth: 150, maxHeight: 70)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle(event.title)
        .navigationBarTitleDisplayMode(.automatic)
        .toolbarColorScheme(ColorScheme.dark)
        .background(Color(.customColorBackground))
        .foregroundStyle(Color(.customWhite))
    }
}
