//
//  AddTransactionView.swift
//  FinTrack
//
//  Created by Diggo Silva on 16/01/26.
//

import UIKit

protocol AddTransactionViewDelegate: AnyObject {
    func didTapSaveButton()
}

class AddTransactionView: UIView {
    
    weak var delegate: AddTransactionViewDelegate?
    
    // MARK: Scroll
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        dp.preferredDatePickerStyle = .wheels
        return dp
    }()
    
    lazy var incomeTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "R$ Entrada"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    lazy var incomeDescriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Descrição de entrada"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.autocapitalizationType = .words
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    lazy var expenseTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "R$ Saída"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    lazy var expenseDescriptionTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Descrição de saída"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.autocapitalizationType = .words
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    private lazy var saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Salvar", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return btn
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [datePicker, incomeTextField, incomeDescriptionTextField, expenseTextField, expenseDescriptionTextField, saveButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(vStack)
        backgroundColor = .systemBackground
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapSaveButton() {
        delegate?.didTapSaveButton()
    }
}
