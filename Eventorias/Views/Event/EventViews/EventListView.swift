//
//  EventListView.swift
//  Eventorias
//
//  Created by Renaud Leroy on 31/12/2025.
//

import SwiftUI

struct EventListView: View {
    let vm: EventViewModel
    @State private var isShowingCreateEvent = false
    @State private var searchQuery: String = ""
    @State private var selectedSorting: SortingType = .date
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                    TextField("", text: $searchQuery)
                }
                .foregroundStyle(.customWhite)
                .padding(.horizontal, 12)
                .frame(height: 35)
                .background(Color(.customGrey))
                .cornerRadius(35)
                Button {
                    selectedSorting = (selectedSorting == .date) ? .category : .date
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.arrow.down")
                        Text("Sorting")
                    }
                    .frame(maxWidth: 105, maxHeight: 35)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .background(Color(.customGrey))
                    .cornerRadius(35)
                    .onChange(of: searchQuery) {
                        vm.query = searchQuery
                        vm.applyFilter(query: searchQuery)
                    }
                }
                List {
                    if vm.isLoading {
                        LoadingListView()
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    } else {
                        let sortedEvents = vm.filteredEventsList.sorted {
                            switch selectedSorting {
                            case .date:
                                return $0.date < $1.date
                            case .category:
                                return $0.category.rawValue < $1.category.rawValue
                            }
                        }
                        
                        ForEach(sortedEvents) { event in
                            NavigationLink {
                                EventDetailView(event: event)
                            } label: {
                                EventRow(event: event)
                            }
                            .listRowInsets(EdgeInsets(
                                top: 6,
                                leading: 0,
                                bottom: 6,
                                trailing: 0
                            ))
                            .buttonStyle(.plain)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                .task {
                    await vm.loadEventsIfNeeded()
                    vm.applyFilter(query: searchQuery)
                }
                
            }
            .refreshable(action: {
                await vm.loadEvents()
                vm.applyFilter(query: searchQuery)
            })
            .padding()
            .scrollIndicators(.hidden)
            .navigationLinkIndicatorVisibility(.hidden)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $isShowingCreateEvent) {
                CreateEventView(vm: vm)
            }
            Button {
                isShowingCreateEvent = true
            } label: {
                AddEventButton()
                    .padding(16)
            }
        }
        .animation(.easeInOut, value: vm.isLoading)
    }
}

struct AddEventButton: View {
    var body: some View {
        Image(systemName: "plus")
            .frame(width: 55, height: 55)
            .foregroundStyle(Color.white)
            .background(.customRed)
            .cornerRadius(16)
    }
}

struct ErrorView: View {
    let retryAction: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color(.customGrey))
                    .frame(width: 64, height: 64)
                Text("!")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Text("Error")
                .font(.title2)
                .fontWeight(.semibold)
            Text("An error has occurred,\nplease try again later")
                .font(.body)
                .multilineTextAlignment(.center)
            TryAgainButton()
        }
        .foregroundColor(.white)
        .background(.customColorBackground)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TryAgainButton: View {
    var body: some View {
        Text("Try again")
            .frame(width: 150, height: 55)
            .foregroundStyle(Color.white)
            .background(.customRed)
            .cornerRadius(4)
    }
}

enum SortingType: String, CaseIterable {
    case category
    case date
}


#Preview {
    EventListView(vm: EventViewModel(repository: EventRepository()))
}
