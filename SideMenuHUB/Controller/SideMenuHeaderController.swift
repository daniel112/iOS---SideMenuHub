//
//  SideMenuHeaderController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class SideMenuHeaderController: ListSectionController {

    weak var delegate:SideMenuOptionSectionControllerDelegate?
    var revealWidth:CGFloat?
    var headerObject:SideMenuHeader?
    
    override init() {
        super.init()
    }
    
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:SideMenuHeaderCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: SideMenuHeaderCollectionViewCell.self, for: self, at: index) as! SideMenuHeaderCollectionViewCell
        
        cell.name = self.headerObject!.name
        cell.image = self.headerObject!.image
        cell.updateWithRevealWidth(revealWidth: self.revealWidth!)
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        self.headerObject = object as? SideMenuHeader
    }
    
    override func didSelectItem(at index: Int) {}
}
