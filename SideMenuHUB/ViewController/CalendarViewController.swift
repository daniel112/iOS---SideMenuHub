//
//  CalendarViewController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/23/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarViewController: BaseViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    //MARK: Private Variables
    fileprivate var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.allowsMultipleSelection = true
        calendar.backgroundColor = UIColor.white
        calendar.clipsToBounds = true //hide top-bottom border
        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        return calendar
    }()
    //MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        self.setupView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private method
    private func setupView() {
        
        //Wrapper
        let wrapper = UIView()
        self.view.addSubview(wrapper)
        wrapper.backgroundColor = UIColor.white
        wrapper.snp.makeConstraints({ (make) in
            make.left.equalTo(self.view)
            make.size.equalTo(self.view)
            make.top.equalTo(self.view)
        })
        //Calendar
        self.calendar.dataSource = self
        self.calendar.delegate = self

        wrapper.addSubview(self.calendar)
        self.calendar.snp.updateConstraints { (make) in
            make.width.equalTo(wrapper.snp.width)
            make.height.equalTo(wrapper.snp.height)
           make.top.equalTo(self.navigationController!.navigationBar.frame.height)
        }

    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
            // Do other updates
        }
        self.view.layoutIfNeeded()
    }


}
