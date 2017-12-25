//
//  EmbeddedSectionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/25/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class CalendarOptionSectionController: ListSectionController {

    //MARK: Private Variable
    fileprivate var optionArray:Array  = [ModuleOption]()
    
    var width:CGFloat?
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return self.optionArray.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.width!, height: collectionContext!.containerSize.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: CalendarOptionCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? CalendarOptionCollectionViewCell else {
                                                                    fatalError()
        }
        
        cell.name = self.optionArray[index].name
        cell.image = self.optionArray[index].image
        cell.updateView()
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        let diffableArray:ListDiffableArray = object as! ListDiffableArray
        self.optionArray = diffableArray.array! as! Array<ModuleOption>
    }
    
    override func didSelectItem(at index: Int) {}
}
