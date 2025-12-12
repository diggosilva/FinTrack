//
//  SFSymbols.swift
//  FinTrack
//
//  Created by Diggo Silva on 06/12/25.
//

import UIKit

class SFSymbols {
    private static func symbol(_ name: String, tint: UIColor? = nil) -> UIImage {
        let image = UIImage(systemName: name) ?? UIImage(systemName: "questionmark.circle")!
        
        if let tint {
            return image.withTintColor(tint, renderingMode: .alwaysOriginal)
        }
        return image
    }
    
    static let upArrow = symbol("arrowshape.up.fill", tint: .systemGreen)
    static let downArrow = symbol("arrowshape.down.fill", tint: .systemRed)
    static let plusCircle = symbol("plus.circle")
    static let plusCircleFill = symbol("plus.circle.fill")
    static let chartBar = symbol("chart.bar")
    static let chartBarFill = symbol("chart.bar.fill")
    static let dollarSign = symbol("dollarsign.arrow.trianglehead.counterclockwise.rotate.90", tint: .label)
    static let calendar = symbol("calendar.circle")
    static let calendarFill = symbol("calendar.circle.fill")
}
