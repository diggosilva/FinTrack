//
//  AddTransactionViewModel.swift
//  FinTrack
//
//  Created by Diggo Silva on 04/12/25.
//

import Foundation

protocol AddTransactionViewModelDelegate: AnyObject {
    func errorOccured(_ message: String)
    func savedTransaction()
}

protocol AddTransactionViewModelProtocol: AnyObject {
    var delegate: AddTransactionViewModelDelegate? { get set }
    func save(date: Date, incomeText: String?, expenseText: String?)
}

class AddTransactionViewModel: AddTransactionViewModelProtocol {
    
    weak var delegate: AddTransactionViewModelDelegate?
    private let repository = TransactionRepository()
    
    func save(date: Date, incomeText: String?, expenseText: String?) {
        let hasIncome = !(incomeText?.isEmpty ?? true)
        let hasExpense = !(expenseText?.isEmpty ?? true)
        
        guard hasIncome || hasExpense else {
            delegate?.errorOccured("Você deve informar pelo menos um dos valores (Entrada ou Saída).")
            return
        }
        
        var income: Double = 0.0
        var expense: Double = 0.0
        
        if hasIncome {
            guard let incomeValue = Double(incomeText ?? "") else {
                delegate?.errorOccured("Valor de entrada inválido.")
                return
            }
            income = incomeValue
        }
        
        if hasExpense {
            guard let expenseValue = Double(expenseText ?? "") else {
                delegate?.errorOccured("Valor de saída inválido.")
                return
            }
            expense = expenseValue
        }
        
        let transaction = TransactionModel(date: date, income: income, expense: expense)
        
        var list = repository.load()
        list.append(transaction)
        repository.save(list)
        
        delegate?.savedTransaction()
    }
}
