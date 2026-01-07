//
//  LoadingListView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 06/01/2026.
//

import SwiftUI

struct LoadingListView: View {
    var body: some View {
        ZStack {
            Color.customColorBackground

            VStack {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2)
                    .tint(.white)
                Text("Loading events...")
                    .font(.default)
                    .foregroundColor(.white)
                    .padding(10)
            }
        }
    }
}
#Preview {
    LoadingListView()
}
