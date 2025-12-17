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
    
    private lazy var yearPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        picker.locale = Locale(identifier: "pt_BR")
        picker.addTarget(self, action: #selector(yearDidChange), for: .valueChanged)
        return picker
    }()
    
    private lazy var tableView: UITableView = {
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
        configureInitialYear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadData()
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
        view.backgroundColor = .systemBackground
        view.addSubview(yearPicker)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            yearPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            yearPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: yearPicker.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureInitialYear() {
        let calendar = Calendar.current
        let date = calendar.date(from: DateComponents(year: viewModel.selectedYear)) ?? Date()
        yearPicker.date = date
    }

    @objc private func yearDidChange() {
        let calendar = Calendar.current
        let selectedYear = calendar.component(.year, from: yearPicker.date)
        
        viewModel.updateYear(selectedYear)
        tableView.reloadData()
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
