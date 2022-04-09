//
//  Extension + UIView.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 07.04.2022.
//

import UIKit

extension UIView {
        func removeSubLayer() {
        self.layer.sublayers?
            .filter { $0.name == "gradientColor" }
            .forEach { $0.removeFromSuperlayer() }
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
           clipsToBounds = true
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
           gradientLayer.frame = self.bounds
           gradientLayer.startPoint = CGPoint(x: 0, y: 0)
           gradientLayer.endPoint = CGPoint(x: 0, y: 1)
           gradientLayer.name = "gradientColor"
           self.layer.insertSublayer(gradientLayer, at: 0)
       }
}
