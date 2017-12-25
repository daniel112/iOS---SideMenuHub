//
//  CalendarSectionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/24/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit
import FSCalendar

class CalendarSectionController: ListSectionController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{

    //MARK: Public Variable
    var delegate:CalendarViewController?
    
    //MARK: Private Variable

    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 300)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell:CalendarCollectionViewCell = self.collectionContext!.dequeueReusableCell(of: CalendarCollectionViewCell.self, for: self, at: index) as! CalendarCollectionViewCell
        
        cell.delegate = self.delegate
        cell.updateView()
        return cell
        
    }
    
    override func didUpdate(to object: Any) {

    }
    
    override func didSelectItem(at index: Int) {
    }
}
