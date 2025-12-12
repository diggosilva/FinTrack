//
//  YearSummaryViewModel.swift
//  FinTrack
//
//  Created by Diggo Silva on 11/12/25.
//

import Foundation

struct MonthSummary {
    let month: String
    let totalIncome: Double
    let totalExpenses: Double
    
    var movement: Double {
        totalIncome + totalExpenses
    }
}

protocol YearSummaryViewModelProtocol {
    func updateYear(_ year: Int)
    func numberOfRows() -> Int
    func summaryForMonth(at index: Int) -> MonthSummary
}

class YearSummaryViewModel: YearSummaryViewModelProtocol {
    
    private let repository = TransactionRepository()
    private var monthSummaries: [MonthSummary] = []
    private(set) var selectedYear: Int
    
    private var transactions: [TransactionModel] = []
    
    init(year: Int) {
        self.selectedYear = year
        transactions = repository.load()
        updateYear(year)
    }
    
    func updateYear(_ year: Int) {
        self.selectedYear = year
        loadMonthSummaries(for: year)
    }
    
    private func loadMonthSummaries(for year: Int) {
        let calendar = Calendar.current
        let transactionsFromYear = filterByYear()
        let grouped = groupedByMonth(transactionsFromYear: transactionsFromYear, calendar: calendar)
        monthSummaries = monthSummaryForEachMonth(groupedByMonth: grouped)
    }
    
    private func filterByYear() -> [TransactionModel] {
        let calendar = Calendar.current
        return transactions.filter { transaction in
            calendar.component(.year, from: transaction.date) == selectedYear
        }
    }
    
    private func groupedByMonth(transactionsFromYear: [TransactionModel], calendar: Calendar) -> [Int: [TransactionModel]] {
        let groupedByMonth = Dictionary(grouping: transactionsFromYear) { transaction in
            calendar.component(.month, from: transaction.date)
        }
        return groupedByMonth
    }
    
    private func monthSummaryForEachMonth(groupedByMonth: [Int: [TransactionModel]]) -> [MonthSummary] {
        let monthNames = Calendar.current.shortMonthSymbols
        var summaries: [MonthSummary] = []
        
        for monthNumber in 1...12 {
            let transactionsFromMonth = groupedByMonth[monthNumber] ?? []
            let totalIncome = transactionsFromMonth.reduce(0) { $0 + $1.income }
            let totalExpense = transactionsFromMonth.reduce(0) { $0 + $1.expense }
            
            let monthSummary = MonthSummary(
                month: monthNames[monthNumber - 1],
                totalIncome: totalIncome,
                totalExpenses: totalExpense
            )
            summaries.append(monthSummary)
        }
        return summaries
    }
    
    func numberOfRows() -> Int {
        return monthSummaries.count
    }
    
    func summaryForMonth(at index: Int) -> MonthSummary {
        return monthSummaries[index]
    }
}
