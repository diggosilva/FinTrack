//
//  ViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 02/12/25.
//

import UIKit

class AddTransactionViewController: UIViewController {

    private let viewModel = AddTransactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDelegates()
    }
    
    private func configureDelegates() {
        viewModel.delegate = self
    }
}

extension AddTransactionViewController: AddTransactionViewModelDelegate {
    func errorOccured(_ message: String) {
        presentDSAlert(title: "Ops... ❌", message: message)
    }
    
    func savedTransaction() {
        presentDSAlert(title: "Tudo certo! ✅", message: "Transação salva com sucesso!")
    }
}
