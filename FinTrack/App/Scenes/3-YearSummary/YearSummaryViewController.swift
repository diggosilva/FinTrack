//
//  YearSummaryViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 10/12/25.
//

import UIKit

class YearSummaryViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell .defaultContentConfiguration()
        content.image = SFSymbols.calendar
        content.text = "Mês \(indexPath.row + 1)"
        content.secondaryText = "R$ 1000,00"
        
        cell.contentConfiguration = content
        return cell
    }
}

extension YearSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Clicou em \(indexPath.row + 1)")
    }
}
