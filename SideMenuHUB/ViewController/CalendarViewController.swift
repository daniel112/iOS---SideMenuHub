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
import IGListKit

class CalendarViewController: BaseViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, UIGestureRecognizerDelegate, ListAdapterDataSource {

    //MARK: Private Variables
    fileprivate var calendarViewObjects:Array = [ListDiffable]()
    
    fileprivate lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    fileprivate let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        view.alwaysBounceVertical = true
        return view
    }()
    
    //MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        self.setupView()
        self.getCalendarObjects()
        self.adapter.performUpdates(animated: true, completion: nil)
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
    fileprivate func setupView() {
        
        //collectionView
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self

    }
    
    fileprivate func getCalendarObjects() {
        
        let calendarConfig:CalendarConfig = CalendarConfig.init(WithProperties: 300, backgroundColor: UIColor.white, clipsToBound: true, allowMultiSelect: true)
        self.calendarViewObjects.append(calendarConfig)
        //self.sideMenuObjects.append(ListDiffableArray.init(withArray: options))
        
        
    }
    
    //MARK: FSCalendarDelegate
    
    //Tells the delegate a date in the calendar is deselected by tapping.
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Deselect Date \(date)")
    }
    // Tells the delegate a date in the calendar is selected by tapping.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected Date \(date)")
    }


     //Asks the delegate whether the specific date is allowed to be selected by tapping.
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }

    //MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.calendarViewObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if (object is CalendarConfig) {
            let sectionController:CalendarSectionController = CalendarSectionController()
            sectionController.delegate = self
            return sectionController
        }
        else {
            let sectionController:CalendarSectionController = CalendarSectionController()
            sectionController.delegate = self
            return sectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
