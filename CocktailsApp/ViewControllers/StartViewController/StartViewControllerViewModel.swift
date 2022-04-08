//
//  StartViewControllerViewModel.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 31.03.2022.
//

import UIKit

protocol StartViewModelProtocol {
    var cells: [CloudCellViewModel] { get }
    func fetchCocktails( _ viewController: UIViewController, completion: @escaping() -> ())
    func searchCocktail(_ searchText: String?, completion: @escaping () -> ())
    func numberOfRows() -> Int
}

class StartViewModel: StartViewModelProtocol {
    //MARK: - Properties
    var cells: [CloudCellViewModel] = []
   
    //MARK: - Methods
    func fetchCocktails(_ viewController: UIViewController, completion: @escaping () -> ()) {
        NetworkManager.shared.fetchData { [unowned self] result  in
            switch result {
            case .success(let cocktails):
                self.cells = getCellsArray(cocktails)
                completion()
            case .failure(let error):
                viewController.showAlert("Error", error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func searchCocktail(_ searchText: String?, completion: @escaping () -> ()) {
        guard let searchText = searchText else { return }
        
        cells.forEach { cell in
            if cell.buttonName.lowercased() == searchText.lowercased() {
                cell.cellSelect()
                completion()                
            }
        }
    }
    
    //MARK: - Create Cells
    private func getCellsArray(_ cocktails: [Cocktail]) -> [CloudCellViewModel] {
        var clouds: [CloudCellViewModel] = []
        cocktails.forEach {
            let cloudCell = CloudCellViewModel($0)
            clouds.append(cloudCell)
        }
        return clouds
    }
}
