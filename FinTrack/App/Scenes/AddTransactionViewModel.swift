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

protocol AddTransactionViewModelProtocol {
    func save(date: Date, incomeText: String?, expenseText: String?)
}

class AddTransactionViewModel: AddTransactionViewModelProtocol {
    
    weak var delegate: AddTransactionViewModelDelegate?
    
    func save(date: Date, incomeText: String?, expenseText: String?) {
        guard let incomeText = incomeText, !incomeText.isEmpty,
              let expenseText = expenseText, !expenseText.isEmpty else {
            delegate?.errorOccured("Preencha todos os campos.")
            return
        }
        
        guard let income = Double(incomeText),
              let expense = Double(expenseText) else {
            delegate?.errorOccured("Valores inválidos.")
            return
        }
        
        delegate?.savedTransaction()
    }
}
