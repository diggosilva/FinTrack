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
    var transactionToEdit: TransactionModel? { get set }
    func save(date: Date, incomeText: String?, incomeDescription: String?, expenseText: String?, expenseDescription: String?)
}

class AddTransactionViewModel: AddTransactionViewModelProtocol {
    
    weak var delegate: AddTransactionViewModelDelegate?
    private let repository: TransactionRepositoryProtocol
    
    var transactionToEdit: TransactionModel?
    
    init(repository: TransactionRepositoryProtocol = TransactionRepository()) {
        self.repository = repository
    }
    
    func save(date: Date, incomeText: String?, incomeDescription: String?, expenseText: String?, expenseDescription: String?) {
        let hasIncome = !(incomeText?.isEmpty ?? true)
        let hasExpense = !(expenseText?.isEmpty ?? true)
        
        guard hasIncome || hasExpense else {
            delegate?.errorOccured("Você deve informar pelo menos um dos valores (Entrada ou Saída).")
            return
        }
        
        let cleanIncome = incomeText?.replacingOccurrences(of: ",", with: ".") ?? ""
        let cleanExpense = expenseText?.replacingOccurrences(of: ",", with: ".") ?? ""
        
        let income = Double(cleanIncome) ?? 0.0
        let expense = Double(cleanExpense) ?? 0.0
        
        var list = repository.load()
        
        if let editingTransaction = transactionToEdit {
            if let index = list.firstIndex(where: { $0.id == editingTransaction.id }) {
                let updatedTransaction = TransactionModel(
                    id: editingTransaction.id, // Mantém o mesmo ID
                    date: date,
                    income: income,
                    incomeDescription: incomeDescription,
                    expense: expense,
                    expenseDescription: expenseDescription
                )
                list[index] = updatedTransaction
            }
        } else {
            let newTransaction = TransactionModel(
                date: date,
                income: income,
                incomeDescription: incomeDescription,
                expense: expense,
                expenseDescription: expenseDescription
            )
            list.append(newTransaction)
        }
        
        repository.save(list)
        delegate?.savedTransaction()
    }
}
