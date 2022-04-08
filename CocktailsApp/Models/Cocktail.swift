//
//  Cocktail.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 30.03.2022.
//

import Foundation

struct Drinks: Decodable {
    let drinks: [Cocktail]
}

struct Cocktail: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}


