//
//  EventoriasViewModelTests.swift
//  EventoriasTests
//
//  Created by Renaud Leroy on 31/12/2025.
//

import XCTest
@testable import Eventorias

@MainActor
final class EventoriasViewModelTests: XCTestCase {
    
    var repository: MockEventRepository!
    var viewModel: EventViewModel!
    
    @MainActor
    override func setUp() {
        super.setUp()
        repository = MockEventRepository()
        viewModel = EventViewModel(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        repository = nil
        viewModel = nil
    }

    func test_loadEventsIfNeeded_loadsOnlyOnce() async {
        // GIVEN
        let event1 = Event(
                id: UUID(),
                title: "Concert Rock",
                description: "Desc",
                date: Date(),
                address: "Paris",
                category: .music,
                imageURL: nil
            )
        repository.eventsToReturn = [event1]

        // WHEN
        await viewModel.loadEventsIfNeeded()
        await viewModel.loadEventsIfNeeded()

        // THEN
        XCTAssertEqual(repository.fetchCallCount, 1)
        XCTAssertEqual(viewModel.eventsList.count, 1)
    }
    
    func test_applyFilter_filtersByTitle() {
        // GIVEN
        let event1 = Event(
                id: UUID(),
                title: "Concert Rock",
                description: "Desc",
                date: Date(),
                address: "Paris",
                category: .music,
                imageURL: nil
            )
        let event2 = Event(
                id: UUID(),
                title: "Conférence Swift",
                description: "Desc",
                date: Date(),
                address: "Lyon",
                category: .technology,
                imageURL: nil
            )

        viewModel.eventsList = [event1, event2]

        // WHEN
        viewModel.applyFilter(query: "Swift")

        // THEN
        XCTAssertEqual(viewModel.filteredEventsList.count, 1)
        XCTAssertEqual(viewModel.filteredEventsList.first?.title, "Conférence Swift")
    }
    
    func test_createEvent_addsEvent() async throws {
        // WHEN
        try await viewModel.createEvent(
            title: "New Event",
            description: "Desc",
            date: Date(),
            address: "Paris",
            category: .music,
            image: nil
        )

        // THEN
        XCTAssertEqual(repository.eventsToReturn.count, 1)
        XCTAssertEqual(viewModel.eventsList.count, 1)
    }
    
}

