//
//  UIViewController Extension.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/28/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import Foundation

//Dismissing Keyboard on tap
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
