//
//  YearSummaryCell.swift
//  FinTrack
//
//  Created by Diggo Silva on 12/12/25.
//

import UIKit

final class YearSummaryCell: UITableViewCell {
    
    static let identifier = "YearSummaryCell"
    
    lazy var monthLabel = buildLabel(size: 12, weight: .semibold)
    
    lazy var movementImage = buildIcon(systemImage: SFSymbols.dollarSign)
    lazy var movementLabel = buildLabel(size: 12)
    
    lazy var hStackMovement: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [movementImage, movementLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    lazy var incomeImage = buildIcon(systemImage: SFSymbols.upArrow)
    lazy var incomeLabel = buildLabel(size: 12)
    
    lazy var hStackIncome: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [incomeImage, incomeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    lazy var expenseImage = buildIcon(systemImage: SFSymbols.downArrow)
    lazy var expenseLabel = buildLabel(size: 12)
    
    lazy var hStackExpense: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [expenseImage, expenseLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hStackIncome, hStackExpense])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        return stack
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [hStackMovement, vStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
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
        contentView.addSubview(monthLabel)
        contentView.addSubview(hStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            incomeImage.widthAnchor.constraint(equalToConstant: 14),
            incomeImage.heightAnchor.constraint(equalTo: incomeImage.widthAnchor),
            
            expenseImage.widthAnchor.constraint(equalTo: incomeImage.widthAnchor),
            expenseImage.heightAnchor.constraint(equalTo: incomeImage.heightAnchor),
            
            monthLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            monthLabel.widthAnchor.constraint(equalToConstant: 40),
            
            hStack.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            hStack.leadingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 8),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(summary: MonthSummary) {
        monthLabel.text = summary.month
        movementLabel.text = formatCurrency(summary.movement)
        incomeLabel.text = formatCurrency(summary.totalIncome)
        incomeLabel.textColor = .systemGreen
        expenseLabel.text = formatCurrency(summary.totalExpenses)
        expenseLabel.textColor = .systemRed
    }
}
