//
//  CalendarCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/24/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Variable
    var delegate:CalendarViewController?
    
    //MARK: Private Variable
    fileprivate var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.allowsMultipleSelection = true
        calendar.backgroundColor = UIColor.white
        calendar.clipsToBounds = true //hide top-bottom border
        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        return calendar
        }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self.delegate
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    //MARK: Public Method
    func updateView() {
        //Calendar

        self.contentView.addGestureRecognizer(self.scopeGesture)
        self.calendar.dataSource = self.delegate
        self.calendar.delegate = self.delegate
        
        self.contentView.addSubview(self.calendar)
        self.calendar.snp.updateConstraints { (make) in
            make.width.equalTo(self.contentView.frame.width)
            make.height.equalTo(300)
            make.top.equalTo(self.contentView)
        }
      
    }
}
