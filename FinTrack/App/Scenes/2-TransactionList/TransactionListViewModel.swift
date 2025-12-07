//
//  TransactionListViewModel.swift
//  FinTrack
//
//  Created by Diggo Silva on 06/12/25.
//

import Foundation

protocol TransactionListViewModelProtocol: AnyObject {
    var transactions: [TransactionModel] { get }
    func loadTransactions()
    func numberOfRows() -> Int
    func transactionForRow(at index: Int) -> TransactionModel
}

final class TransactionListViewModel: TransactionListViewModelProtocol {
    
    private(set) var transactions: [TransactionModel] = []
    
    func loadTransactions() {
        #warning("Implement the data fetching here")
        
        //Mock apenas pra ver se a lista está funcionando
        transactions = [
            TransactionModel(date: Date(), income: 100.0, expense: 0.0),
            TransactionModel(date: Date().addingTimeInterval(-86_400), income: 50.0, expense: 0.0),
            TransactionModel(date: Date().addingTimeInterval(-172_800), income: 0.0, expense: 25.0),
            TransactionModel(date: Date().addingTimeInterval(-1_728_000), income: 0.0, expense: 30.0),
        ]
    }
    
    func numberOfRows() -> Int {
        transactions.count
    }
    
    func transactionForRow(at index: Int) -> TransactionModel {
        return transactions[index]
    }
}
