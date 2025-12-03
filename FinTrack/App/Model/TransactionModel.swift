//
//  TransactionModel.swift
//  FinTrack
//
//  Created by Diggo Silva on 02/12/25.
//

import Foundation

struct TransactionModel: Codable {
    let id: UUID
    let date: Date
    let income: Double
    let expense: Double
    
    init(date: Date, income: Double, expense: Double) {
        self.id = UUID()
        self.date = date
        self.income = income
        self.expense = expense
    }
}
