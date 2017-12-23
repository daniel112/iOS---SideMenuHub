//
//  SideMenuOptionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

//MARK: Protocols
protocol SideMenuOptionSectionControllerDelegate:class {
    func didSelectSideMenuOptionItem(item:ModuleOption)
}

class SideMenuOptionController: ListSectionController {

    weak var delegate:SideMenuOptionSectionControllerDelegate?
    var revealWidth:CGFloat?
    var optionArray:Array  = [ModuleOption]()
    
    override init() {
        super.init()
        //This adds a 15 point padding to the bottom of these objects
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }

    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return optionArray.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        //return .zero
        return CGSize(width: 100, height: 55)
    }
    
    //NOT HITTING THIS FUNC??
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:SideMenuOptionCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: SideMenuOptionCollectionViewCell.self, for: self, at: index) as! SideMenuOptionCollectionViewCell
        
        cell.name = self.optionArray[index].name
        cell.image = self.optionArray[index].image
        cell.updateWithRevealWidth(revealWidth: self.revealWidth!)
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        
        let diffableArray:ListDiffableArray = object as! ListDiffableArray
        self.optionArray = diffableArray.array!
    }
    
    override func didSelectItem(at index: Int) {}
    
}




