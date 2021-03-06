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
protocol SideMenuOptionSectionControllerDelegate {
    func didSelectSideMenuOptionItem(item:ModuleOption)
}

class SideMenuOptionController: ListSectionController {

    var delegate:SideMenuOptionSectionControllerDelegate?
    var revealWidth:CGFloat?
    var optionArray:Array  = [ModuleOption]()
    
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return self.optionArray.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:SideMenuOptionCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: SideMenuOptionCollectionViewCell.self, for: self, at: index) as! SideMenuOptionCollectionViewCell 
        
        cell.name = self.optionArray[index].name
        cell.image = self.optionArray[index].image
        cell.updateWithRevealWidth(revealWidth: self.revealWidth!)
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        
        let diffableArray:ListDiffableArray = object as! ListDiffableArray
        self.optionArray = diffableArray.array! as! Array<ModuleOption>
    }
    
    override func didSelectItem(at index: Int) {
        
        //if delegate exists and conforms to method
        if let delegateVC = self.delegate {
            delegateVC.didSelectSideMenuOptionItem(item: self.optionArray[index])
        }
        
    }
    
}




