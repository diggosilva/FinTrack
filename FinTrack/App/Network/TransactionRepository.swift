//
//  TransactionRepository.swift
//  FinTrack
//
//  Created by Diggo Silva on 03/12/25.
//

import Foundation

final class TransactionRepository {
    
    private let userDefaults = UserDefaults.standard
    private let key = "transactions"
    
    func save(_ transactions: [TransactionModel]) {
        if let encodedTransactions = try? JSONEncoder().encode(transactions) {
            userDefaults.set(encodedTransactions, forKey: key)
        }
    }
    
    func load() -> [TransactionModel] {
        if let data = userDefaults.data(forKey: key) {
            if let decodedTransactions = try? JSONDecoder().decode([TransactionModel].self, from: data) {
                return decodedTransactions
            }
        }
        return []
    }
}
