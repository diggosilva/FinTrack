//
//  MockRepository.swift
//  FinTrackTests
//
//  Created by Diggo Silva on 14/12/25.
//

@testable import FinTrack

class MockRepository: TransactionRepositoryProtocol {
    
    var isSuccess: Bool = true
    var savedTransactions: [TransactionModel] = []
    var saveCalled: Bool = false
    
    func save(_ transactions: [TransactionModel]) {
        if isSuccess {
            savedTransactions = transactions
        } else {
            savedTransactions = []
        }
        saveCalled = true
    }
    
    func load() -> [TransactionModel] {
        return savedTransactions
    }
}
