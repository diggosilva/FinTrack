//
//  Helpers.swift
//  FinTrack
//
//  Created by Diggo Silva on 04/12/25.
//

import UIKit

// MARK: Extensions

extension UIViewController {
    func presentDSAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

// MARK: Methods

func formatDateStyle(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
}

func formatCurrency(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "pt_BR")
    formatter.numberStyle = .currency
    formatter.currencyCode = "BRL"
    guard let formattedString = formatter.string(from: NSNumber(value: value)) else { return "" }
    return formattedString
}
