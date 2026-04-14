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
    let incomeDescription: String?
    let expense: Double
    let expenseDescription: String?
    
    init(id: UUID = UUID(), date: Date, income: Double, incomeDescription: String? = nil, expense: Double, expenseDescription: String? = nil) {
        self.id = id
        self.date = date
        self.income = income
        self.incomeDescription = incomeDescription
        self.expense = expense
        self.expenseDescription = expenseDescription
    }
}
