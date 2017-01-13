//
//  ButtonPanelCVC.swift
//  ElevatorChallenge
//
//  Created by Dwayne Langley on 1/13/17.
//
//

import UIKit

private let reuseIdentifier = "buttonCell"

// MARK: Constants used for size calculation
private let sidePaddings : CGFloat = 1
private let itemsPerRow : CGFloat = 4
private let heightAdjustment : CGFloat = 30.0

class ButtonPanelCVC: UICollectionViewController {

    var delegate : SelectionDelegate?
    
    var floors = 1 {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    // MARK: LifeCycle Methods
    // Moved layout here to handle iPad rotations
    override func viewWillLayoutSubviews() {
        let width = (collectionView!.frame.width - (sidePaddings * (itemsPerRow + 1))) / itemsPerRow
        let height = collectionView!.frame.height/CGFloat(collectionView!.numberOfItems(inSection: 0) + 1)
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return floors
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ButtonCell
    
        // Configure the cell
        cell.floorLabel.text = "\(indexPath.item + 1)"
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.addSelection(floor: indexPath.item + 1)
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}

class ButtonCell: UICollectionViewCell {
    
    @IBOutlet var floorLabel: UILabel!
}

protocol SelectionDelegate {
    func addSelection(floor: Int)
}
