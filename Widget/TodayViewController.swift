//
//  TodayViewController.swift
//  Widget
//
//  Created by Yong Jae Kwon on 2018. 4. 22..
//  Copyright © 2018년 Yong Jae Kwon. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
        
    @IBOutlet var collectionView: UICollectionView!
    let colorArr = ["Blue", "Corn Flower Blue", "Sky Blue", "Cyan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    // compact
    let compactLayout = WidgetFlowLayout(
        cellsPerRow: 4,
        minimumInteritemSpacing: 5,
        minimumLineSpacing: 5,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    // expand
    let expandLayout = WidgetFlowLayout(
        cellsPerRow: 1,
        minimumInteritemSpacing: 5,
        minimumLineSpacing: 5,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            self.preferredContentSize = CGSize(width: 0, height: 110)
            collectionView.setCollectionViewLayout(compactLayout, animated: true)
            
        } else {            
            self.preferredContentSize = CGSize(width: 0, height: 360)
            collectionView.setCollectionViewLayout(expandLayout, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let myCell = cell as? WidgetCollectionViewCell {
            myCell.titleLabel.text = colorArr[indexPath.row]
            myCell.cellImage.backgroundColor = colorForIndex(index: indexPath.row)
        }
        
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let color = (CGFloat(index) / CGFloat(5)) * 2.0
        return UIColor(red: 0, green: color, blue: 1.0, alpha: 1.0)
    }
    
    // TODO: scheme 만들어서 색상 별로 뷰로 이동하게 만들기
    @IBAction func moveDetailVC(_ sender: Any) {
        extensionContext?.open(URL(string: "example://")! , completionHandler: nil)
    }
}
