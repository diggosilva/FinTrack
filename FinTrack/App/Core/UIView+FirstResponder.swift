//
//  UIView+FirstResponder.swift
//  FinTrack
//
//  Created by Diggo Silva on 16/01/26.
//

import UIKit

extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder { return self }
        
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
