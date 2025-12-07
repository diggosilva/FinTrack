//
//  ViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 02/12/25.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    private let viewModel: AddTransactionViewModelProtocol
    
    init(viewModel: AddTransactionViewModelProtocol = AddTransactionViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // DatePicker
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        return dp
    }()
    
    // IncomeTextField
    private lazy var incomeTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Entrada"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // ExpenseTextField
    private lazy var expenseTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Saída"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // SaveButton
    private lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(NSLocalizedString("Salvar", comment: "Teste de comentário"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return btn
    }()
    
    // StackVertical
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [datePicker, incomeTextField, expenseTextField, saveButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureDelegates()
        configureKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(vStack)
        view.backgroundColor = .systemBackground
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            incomeTextField.heightAnchor.constraint(equalToConstant: 44),
            expenseTextField.heightAnchor.constraint(equalToConstant: 44),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapSaveButton() {
        viewModel.save(date: datePicker.date, incomeText: incomeTextField.text, expenseText: expenseTextField.text)
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

// MARK: - Keyboard Handling
extension AddTransactionViewController {
    
    private func configureKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        
        // Só sobe se um desses campos estiver sendo editado
        if incomeTextField.isFirstResponder || expenseTextField.isFirstResponder {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardHeight * 0.35
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
