//
//  KeyboardAwareViewController.swift
//  FinTrack
//
//  Created by Diggo Silva on 16/01/26.
//

import UIKit

class KeyboardAwareViewController: UIViewController {
    
    var keyboardScrollView: UIScrollView? {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObservers()
        setupFieldFocusObservers()
        setupDismissKeyboardGesture()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension KeyboardAwareViewController {
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let scrollView = keyboardScrollView,
            let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }
        
        let keyboardHeight = frame.height
        
        scrollView.contentInset.bottom = keyboardHeight + 16
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        
        DispatchQueue.main.async {
            if let activeField = self.view.findFirstResponder() {
                let rect = activeField.convert(activeField.bounds, to: scrollView)
                scrollView.scrollRectToVisible(rect, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let scrollView = keyboardScrollView else { return }
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension KeyboardAwareViewController {
    
    private func setupFieldFocusObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(fieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fieldDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    @objc private func fieldDidBeginEditing(_ notification: Notification) {
        guard
            let scrollView = keyboardScrollView,
            let field = notification.object as? UIView
        else { return }
        
        DispatchQueue.main.async {
            let rect = field.convert(field.bounds, to: scrollView)
            scrollView.scrollRectToVisible(rect, animated: true)
        }
    }
}

extension KeyboardAwareViewController {
    
    private func setupDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
