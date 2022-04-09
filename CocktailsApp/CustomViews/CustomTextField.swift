//
//  CustomTextField.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 05.04.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    init(_ placeholderName: String, _ cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 0)
        self.layer.shadowOpacity = 0.5
        self.backgroundColor = .white
        self.layer.cornerRadius = cornerRadius
        self.placeholder = placeholderName
        
        let attributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)
        ]
        
        let attr = NSAttributedString(string: placeholderName, attributes: attributes as [NSAttributedString.Key : Any])
        self.attributedPlaceholder = attr
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
        return bounds.insetBy(dx: frame.width * 0.33, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.insetBy(dx: frame.width * 0.33, dy: 0)
    }
}
