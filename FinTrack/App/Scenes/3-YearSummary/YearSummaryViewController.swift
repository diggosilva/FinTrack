//
//  YearSummaryViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 10/12/25.
//

import UIKit

class YearSummaryViewController: UIViewController {
    
    private let viewModel: YearSummaryViewModelProtocol
    
    init(viewModel: YearSummaryViewModelProtocol = YearSummaryViewModel(year: Calendar.current.component(.year, from: Date()))) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(YearSummaryCell.self, forCellReuseIdentifier: YearSummaryCell.identifier)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureNavigationBar()
        configureDelegatesAndDataSources()
        tableView.reloadData()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Movimentações do Ano"
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
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension YearSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YearSummaryCell.identifier, for: indexPath) as? YearSummaryCell else { return UITableViewCell() }
        let monthSummary = viewModel.summaryForMonth(at: indexPath.row)
        cell.configure(summary: monthSummary)
        return cell
    }
}

extension YearSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
