//
//  Extension + UIView.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 07.04.2022.
//

import UIKit

extension UIView {
//    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
//        return self.applyGradient(colours: colours, locations: nil)
//    }
//
//
//    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
//        self.backgroundColor = nil
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.frame
//        gradient.colors = colours.map { $0.cgColor }
//        gradient.locations = locations
//        gradient.name = "gradientColor"
//        self.layer.insertSublayer(gradient, at: 0)
//        return gradient
//    }
    
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
