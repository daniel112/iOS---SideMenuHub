//
//  AddEventViewController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/26/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit
import FSCalendar
class AddEventViewController: BaseViewController, FSCalendarDelegate, FSCalendarDataSource {


    //MARK: Public Variable
    var selectedDates = [Date]()
    
    //MARK: Private Variable
    fileprivate var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.allowsMultipleSelection = true
        calendar.backgroundColor = UIColor.white
        calendar.clipsToBounds = true //hide top-bottom border
        return calendar
    }()

    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        //self.setupView()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeObserver()
    }
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(CalendarViewController.orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    fileprivate func setupView() {
        //Calendar
        self.view.addSubview(self.calendar)
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.calendar.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(300)
            make.left.equalTo(self.view)
            make.top.equalTo((self.navigationController?.navigationBar.frame.height)!)
        }
        for date in self.selectedDates {
            self.calendar.select(date)
        }
        //navigation title
        self.navigationController?.title = "Add Event"
       
    }
    //MARK: - objc Methods
    @objc func orientationDidChange() {
        calendar.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
        }
        //self.adapter.reloadData(completion: nil)
    }
    
    //MARK: FSCalendarDelegate
    
    //needs to update frame when hiding/showing week-month view
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        //update event section
       // self.getCalendarSectionObjects()
       // self.adapter.reloadData(completion: nil)
        self.view.layoutIfNeeded()
    }
    
    //Asks the delegate whether the specific date is allowed to be selected by tapping.
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }

}
