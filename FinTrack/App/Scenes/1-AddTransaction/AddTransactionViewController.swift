//
//  ViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 02/12/25.
//

import UIKit

class AddTransactionViewController: KeyboardAwareViewController {
    
    private let contentView = AddTransactionView()
    private let viewModel: AddTransactionViewModelProtocol
    
    override var keyboardScrollView: UIScrollView? {
        contentView.scrollView
    }
    
    init(viewModel: AddTransactionViewModelProtocol = AddTransactionViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegates()
        setupEditMode()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureDelegates() {
        viewModel.delegate = self
        contentView.delegate = self
    }
    
    private func setupEditMode() {
        if let transaction = viewModel.transactionToEdit {
            title = "Editar Transação"
            contentView.datePicker.date = transaction.date
            contentView.incomeTextField.text = transaction.income > 0 ? "\(transaction.income)" : ""
            contentView.incomeDescriptionTextField.text = transaction.incomeDescription
            contentView.expenseTextField.text = transaction.expense > 0 ? "\(transaction.expense)" : ""
            contentView.expenseDescriptionTextField.text = transaction.expenseDescription
        } else {
            title = "Nova Transação"
        }
    }
}

extension AddTransactionViewController: AddTransactionViewModelDelegate {
    func errorOccured(_ message: String) {
        presentDSAlert(title: "Ops... ❌", message: message)
    }
    
    func savedTransaction() {
        presentDSAlert(title: "Tudo certo! ✅", message: "Transação salva com sucesso!") { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddTransactionViewController: AddTransactionViewDelegate {
    func didTapSaveButton() {
        viewModel.save(
            date: contentView.datePicker.date,
            incomeText: contentView.incomeTextField.text,
            incomeDescription: contentView.incomeDescriptionTextField.text,
            expenseText: contentView.expenseTextField.text,
            expenseDescription: contentView.expenseDescriptionTextField.text
        )
    }
}
