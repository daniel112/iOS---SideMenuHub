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
        //view.alwaysBounceVertical = true
        return view
    }()
    
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
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    //MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        self.setupObserver()
        self.setupView()
        self.setupConstraints()
        self.getCalendarSectionObjects()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        //remove observer to prevent memory leak
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }


    
    //MARK: Private method
    
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(CalendarViewController.orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    fileprivate func setupConstraints() {
        //Calendar
        self.calendar.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(300)
            make.left.equalTo(self.view)
            make.top.equalTo((self.navigationController?.navigationBar.frame.height)!)
        }
        
        //collectionView
        self.collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.calendar.snp.bottom)
            make.left.bottom.right.equalTo(self.view)
        })
    }
    fileprivate func setupView() {
        
        //Calendar
        self.view.addSubview(self.calendar)
        self.view.addGestureRecognizer(self.scopeGesture)
        self.calendar.dataSource = self
        self.calendar.delegate = self
        //collectionView
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = UIColor.blue
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
      
    }
    
    fileprivate func getCalendarSectionObjects() {
        
        //options
        var options:Array = [Any]()
        
        options.append(ModuleOption.init(WithName: "Week", photo: UIImage.init(named: "placeholder_face"))!)
        options.append(ModuleOption.init(WithName: "Month", photo: UIImage.init(named: "calendar"))!)
        
        //store in the global array as a ListDiffableArray type
        self.calendarViewObjects.append(ListDiffableArray.init(withArray: options))
        self.adapter.performUpdates(animated: true, completion: nil)
        
    }
    
    //MARK: - objc Methods
    @objc func orientationDidChange() {
        print("Orientation changed")
        setupConstraints()
        self.adapter.reloadData(completion: nil)
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

    //needs to update frame when hiding/showing week-month view
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
            // Do other updates
        }
        self.view.layoutIfNeeded()
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
        
        //2nd section
        if (object is ListDiffableArray) {
            let sectionController:EmbeddedSectionController = EmbeddedSectionController()
            return sectionController
        }
        else {//3rd section
            //PLACEHOLDER
            let sectionController:EmbeddedSectionController = EmbeddedSectionController()
            return sectionController
            
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
