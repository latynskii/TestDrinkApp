//
//  TagFlowLayout.swift
//  CocktailsApp
//
//  Created by EDUARD Latynsky on 07.04.2022.
//

import UIKit

class Row {
    //MARK: - Properties
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0
    
    //MARK: - Inits
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
   //MARK: - Methods
    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func tagLayout(collectionViewWidth: CGFloat) {
        let padding = 5
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}
     
     //MARK: - CustomFlowLayout
class TagFlowLayout: UICollectionViewFlowLayout {
    //MARK: - Properties
    private var rows = [Row]()
    private var currentRowY: CGFloat = -1
    
    
    //MARK: - Methods
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 8))
            }
            rows.last?.add(attribute: attribute)
        }

        rows.forEach {
            $0.tagLayout(collectionViewWidth: collectionView?.frame.width ?? 0)
        }
        return rows.flatMap { $0.attributes }
    }
}

