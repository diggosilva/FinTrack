//
//  TransactionListViewModel.swift
//  FinTrack
//
//  Created by Diggo Silva on 06/12/25.
//

import Foundation

struct SectionMonth {
    let title: String
    let items: [TransactionModel]
}

protocol TransactionListViewModelProtocol: AnyObject {
    var transactions: [TransactionModel] { get }
    func loadTransactions()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func transactionForRow(in section: Int, at index: Int) -> TransactionModel
    func titleForSection(at index: Int) -> String
}

final class TransactionListViewModel: TransactionListViewModelProtocol {
    
    private var sections: [SectionMonth] = []
    private(set) var transactions: [TransactionModel] = []
    private let repository = TransactionRepository()
    
    init() {
        loadTransactions()
    }
    
    func loadTransactions() {
        transactions = loadAndSort()
        let grouped = groupByMonth(transactions)
        let sortedKeys = sortMonthKeys(grouped.keys)
        sections = buildSections(grouped: grouped, sortedKeys: sortedKeys)
    }
    
    private func loadAndSort() -> [TransactionModel] {
        return repository.load().sorted(by: { $0.date > $1.date })
    }
    
    private func groupByMonth(_ transactions: [TransactionModel]) -> [String : [TransactionModel]] {
        return Dictionary(grouping: transactions) { $0.date.toMonthAndYear() }
    }
    
    private func sortMonthKeys(_ keys: Dictionary<String, [TransactionModel]>.Keys) -> [String] {
        return keys.sorted { $0.toDateFromMonthAndYear() > $1.toDateFromMonthAndYear() }
    }
    
    private func buildSections(grouped: [String : [TransactionModel]], sortedKeys: [String]) -> [SectionMonth] {
        return sortedKeys.map { key in
            SectionMonth(
                title: key,
                items: (grouped[key]!.sorted(by: { $0.date > $1.date }))
            )
        }
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].items.count
    }
    
    func transactionForRow(in section: Int, at index: Int) -> TransactionModel {
        return sections[section].items[index]
    }
    
    func titleForSection(at index: Int) -> String {
        return sections[index].title
    }
}
