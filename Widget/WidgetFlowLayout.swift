//
//  WidgetFlowLayout.swift
//  Widget
//
//  Created by Yong Jae Kwon on 2018. 4. 22..
//  Copyright © 2018년 Yong Jae Kwon. All rights reserved.
//

import UIKit

class WidgetFlowLayout: UICollectionViewFlowLayout {
    
    let cellsPerRow: Int
    
    override var itemSize: CGSize {
        get {
            guard let collectionView = collectionView else {
                return super.itemSize
            }
            
            let insets = sectionInset.left + sectionInset.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - insets) / CGFloat(cellsPerRow)).rounded(.down)
            
            return CGSize(width: itemWidth, height: 80)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()
        
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        
        if let widgetContext = context as? UICollectionViewFlowLayoutInvalidationContext {
            widgetContext.invalidateFlowLayoutDelegateMetrics = newBounds != collectionView?.bounds
        }
        
        return context
    }
}

