//
//  CloudCellViewModel.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 31.03.2022.
//

import Foundation

protocol CloudCellViewModelProtocol {
    
    var isTapped: Bool { get }
    
    var buttonName: String { get }
    
    func cellSelect()
    
    init(_ cocktail: Cocktail)
}

class CloudCellViewModel: CloudCellViewModelProtocol {
    var isTapped: Bool = false
    
    var buttonName: String {
        cocktail.strDrink
    }
    
    var cocktail: Cocktail
    
    required init(_ cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
    func cellSelect() {
        isTapped.toggle()
    }
}
