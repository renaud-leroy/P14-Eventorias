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
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .padding(.horizontal, 20)
            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .font(.headline)
                Text(event.date, style: .date)
                    .font(.subheadline)
            }
            Spacer()
            if let imageURL = event.imageURL,
               let url = URL(string: imageURL) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 130, height: 80)
                .clipped()
                .cornerRadius(14)
            } else {
                Color.gray.opacity(0.3)
                    .frame(width: 130, height: 80)
                    .cornerRadius(14)
            }
        }
        .frame(maxHeight: 80)
        .background(Color(.customGrey))
        .cornerRadius(14)
        .foregroundStyle(Color(.customWhite))
    }
}
