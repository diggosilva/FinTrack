//
//  TransactionListCell.swift
//  FinTrack
//
//  Created by Diggo Silva on 06/12/25.
//

import UIKit

final class TransactionListCell: UITableViewCell {
    
    static let identifier = "TransactionListCell"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var incomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGreen
        return label
    }()
    
    private lazy var hStackIncome: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [incomeImage, incomeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var expenseImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemRed
        return label
    }()
    
    private lazy var hStackExpense: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [expenseImage, expenseLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, hStackIncome, hStackExpense])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
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
    }
    
    private func setHierarchy() {
        contentView.addSubview(vStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            incomeImage.widthAnchor.constraint(equalToConstant: 16),
            incomeImage.heightAnchor.constraint(equalTo: incomeImage.widthAnchor),
            
            expenseImage.widthAnchor.constraint(equalTo: incomeImage.widthAnchor),
            expenseImage.heightAnchor.constraint(equalTo: incomeImage.heightAnchor),
            
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(transaction: TransactionModel) {
        dateLabel.text = formatDateStyle(date: transaction.date)
        
        incomeImage.image = SFSymbols.upArrow
        incomeLabel.text = formatCurrency(transaction.income)
        
        expenseImage.image = SFSymbols.downArrow
        expenseLabel.text = formatCurrency(transaction.expense)
    }
}
