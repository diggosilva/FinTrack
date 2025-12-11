//
//  MainTabBarController.swift
//  FinTrack
//
//  Created by Diggo Silva on 07/12/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let addTransactionVC = UINavigationController(rootViewController: AddTransactionViewController())
    let transactionListVC = UINavigationController(rootViewController: TransactionListViewController())
    let yearSummaryVC = UINavigationController(rootViewController: YearSummaryViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }
    
    private func configTabBar() {
        addTransactionVC.tabBarItem = UITabBarItem(title: "Registrar", image: SFSymbols.plusCircle, selectedImage: SFSymbols.plusCircleFill)
        transactionListVC.tabBarItem = UITabBarItem(title: "Resumo", image: SFSymbols.chartBar, selectedImage: SFSymbols.chartBarFill)
        yearSummaryVC.tabBarItem = UITabBarItem(title: "Ano", image: SFSymbols.calendar, selectedImage: SFSymbols.calendarFill)
        
        viewControllers = [addTransactionVC, transactionListVC, yearSummaryVC]
    }
}
