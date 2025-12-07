//
//  TransactionListViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 06/12/25.
//

import UIKit

class TransactionListViewController: UIViewController {
    
    private let viewModel: TransactionListViewModelProtocol
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(TransactionListCell.self, forCellReuseIdentifier: TransactionListCell.identifier)
        return tv
    }()
    
    init(viewModel: TransactionListViewModelProtocol = TransactionListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureNavigationBar()
        configureDelegatesAndDataSources()
        viewModel.loadTransactions()
        tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Transações"
    }
    
    private func configureDelegatesAndDataSources() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension TransactionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionListCell.identifier, for: indexPath) as? TransactionListCell else { return UITableViewCell() }
        let transaction = viewModel.transactionForRow(at: indexPath.row)
        cell.configure(transaction: transaction)
        return cell
    }
}

extension TransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
