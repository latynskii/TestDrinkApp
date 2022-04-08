//
//  Extension + UIViewController.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 08.04.2022.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String,_ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
