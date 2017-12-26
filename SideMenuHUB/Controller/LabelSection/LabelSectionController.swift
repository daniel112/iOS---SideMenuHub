//
//  CalendarEventHeaderSectionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/25/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class LabelSectionController: ListSectionController {

    //MARK: Private Variable
    fileprivate var headerLabel:String?
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 50)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: LabelCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? LabelCollectionViewCell else {
                                                                    fatalError()
        }
        
        cell.name = self.headerLabel!
        cell.updateView()
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        self.headerLabel = object as? String
    }
    
    override func didSelectItem(at index: Int) {}
}
