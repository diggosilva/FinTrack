//
//  TransactionListCell.swift
//  FinTrack
//
//  Created by Diggo Silva on 06/12/25.
//

import UIKit

final class TransactionListCell: UITableViewCell {
    
    static let identifier = "TransactionListCell"
    
    private lazy var dateLabel = buildLabel(size: 14, weight: .medium)
    
    private lazy var incomeImage = buildIcon(systemImage: SFSymbols.upArrow)
    private lazy var incomeLabel = buildLabel(size: 12)
    private lazy var incomeDescriptionLabel: UILabel = {
        let label = buildLabel(size: 12, textAlignment: .right, numberOfLines: 0)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
   
    private lazy var hStackIncome: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [incomeImage, incomeLabel, incomeDescriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top // Mantém ícone e valor no topo se a descrição crescer
        return stackView
    }()
    
    private lazy var expenseImage = buildIcon(systemImage: SFSymbols.downArrow)
    private lazy var expenseLabel = buildLabel(size: 12)
    private lazy var expenseDescriptionLabel: UILabel = {
        let label = buildLabel(size: 12, textAlignment: .right, numberOfLines: 0)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var hStackExpense: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expenseImage, expenseLabel, expenseDescriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .top // Mantém ícone e valor no topo se a descrição crescer
        return stackView
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, hStackIncome, hStackExpense])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
        configurePriorities()
    }
    
    private func setHierarchy() {
        contentView.addSubview(vStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            incomeImage.widthAnchor.constraint(equalToConstant: 16),
            incomeImage.heightAnchor.constraint(equalToConstant: 16),
            
            expenseImage.widthAnchor.constraint(equalToConstant: 16),
            expenseImage.heightAnchor.constraint(equalToConstant: 16),
            
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private func configurePriorities() {
        // Impede que os valores (R$) sejam "espremidos" (truncados)
        incomeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        expenseLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Garante que eles não tentem esticar mais do que o necessário
        incomeLabel.setContentHuggingPriority(.required, for: .horizontal)
        expenseLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        // Permite que a descrição cresça e empurre o layout
        incomeDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        expenseDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    func configure(transaction: TransactionModel) {
        dateLabel.text = formatDateStyle(date: transaction.date)
        
        // Configuração de Entrada
        let incomeValue = formatCurrency(transaction.income)
        incomeLabel.text = incomeValue
        incomeLabel.textColor = .systemGreen
        incomeDescriptionLabel.text = transaction.incomeDescription
        
        // Esconde a stack de entrada se não houver valor
        hStackIncome.isHidden = transaction.income == 0
        
        // Configuração de Saída
        let expenseValue = formatCurrency(transaction.expense)
        expenseLabel.text = expenseValue
        expenseLabel.textColor = .systemRed
        expenseDescriptionLabel.text = transaction.expenseDescription
        
        // Esconde a stack de saída se não houver valor
        hStackExpense.isHidden = transaction.expense == 0
    }
}
