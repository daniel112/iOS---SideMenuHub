//
//  CalendarEventSectionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/25/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

protocol CalendarEventSectionDelegate {
    func didSelectEventOptionItem(item:Event)
}

class CalendarEventSectionController: ListSectionController {

    //MARK: Public Variable
    var delegate:CalendarEventSectionDelegate?
    
    //MARK: Private Variable
    fileprivate var listArray = [Event]()
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return listArray.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 50)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: CalendarEventCollectionViewCell.self,
                                          for: self,
                                           at: index) as? CalendarEventCollectionViewCell else {
                                                                    fatalError()
        }
        
        cell.name = self.listArray[index].name
        cell.participants = self.listArray[index].participants
        cell.icon = self.listArray[index].icon
        cell.updateView()
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        let diffableArray:ListDiffableArray = object as! ListDiffableArray
        self.listArray = diffableArray.array! as! Array<Event>
    }
    
    override func didSelectItem(at index: Int) {}
}
