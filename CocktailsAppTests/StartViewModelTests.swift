//
//  CocktailsAppTests.swift
//  CocktailsAppTests
//
//  Created by EDUARD Latynsky on 08.04.2022.
//

import XCTest
@testable import CocktailsApp

class StartViewModelTests: XCTestCase {
    var cut: StartViewModel!
    
    override func setUp() {
        super.setUp()
        cut = StartViewModel()
    }

    override func tearDown(){
        cut = nil
      super.tearDown()
    }

    func testCheckNumberOfRowsWhenEmptyArrayWithCells()  {
        let assume = cut.numberOfRows()
        XCTAssert(assume == 0)
    }
    
    func testCheckNumberOfRowsWithCellsInArray() {
        let maxNum = 5
        for element in 1...maxNum {
            let cellViewModel = CloudCellViewModel(Cocktail(strDrink: "\(element)",
                                                            strDrinkThumb: "\(element)",
                                                            idDrink: "\(element)"))
            cut.cells.append(cellViewModel)
        }
        XCTAssert(cut.cells.count == maxNum )
    }

    func testPerformanceExample() {
        measure {
            
        }
    }

}
