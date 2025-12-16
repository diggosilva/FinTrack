//
//  MockDelegate.swift
//  FinTrackTests
//
//  Created by Diggo Silva on 14/12/25.
//

@testable import FinTrack

final class MockDelegate: AddTransactionViewModelDelegate {
    var lastErrorMessage: String?
    var savedCalled = false

    func errorOccured(_ message: String) {
        lastErrorMessage = message
    }

    func savedTransaction() {
        savedCalled = true
    }
}
