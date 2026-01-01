//
//  EventRow.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI
import Foundation //Preview


struct EventRow: View {
    let event: Event
    var body: some View {
        HStack(spacing: 0) {
            Image(event.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .padding(.horizontal, 20)
            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.headline)
                Text(event.date)
                    .font(.subheadline)
            }
            Spacer()
            Image(event.cover)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 80)
                .clipped()
                .cornerRadius(14)
        }
        .frame(maxHeight: 80)
        .background(Color(.customGrey))
        .cornerRadius(14)
        .foregroundStyle(Color(.customWhite))
    }
}

#Preview {
    let event = Event(title: "Music festival", date: "June 15, 2024", avatar: "avatar", cover: "imageEvent", description: "Join us for an exclusive Art Exhibition showcasing the works of the talented artist Emily Johnson. This exhibition will feature a captivating collection of her contemporary and classical pieces, offering a unique insight into her creative journey. Whether you're an art enthusiast or a casual visitor, you'll have the chance to explore a diverse range of artworks.", address: "123 Rue de l'Art, Quartier des Galeries, Paris, 75003, France", time: "10:00 AM")
    ZStack {
        Color.customColorBackground.ignoresSafeArea()
        EventRow(event: event)
            .padding()
    }
}


 

