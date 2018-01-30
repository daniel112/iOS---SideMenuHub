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

class CalendarViewController: BaseViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance, UIGestureRecognizerDelegate, ListAdapterDataSource, CalendarOptionSectionControllerDelegate, CalendarEventSectionDelegate {

    //MARK: Private Variables
    fileprivate var calendarViewObjects:Array = [ListDiffable]()
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    fileprivate let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        //view.alwaysBounceVertical = true
        return view
    }()
    fileprivate lazy var addButton:UIBarButtonItem = {
        let image = UIImage.init(named: "add_event")?.withRenderingMode(.alwaysOriginal)
        let button = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.buttonAdd_touchUpInside(sender:)))
        return button
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
    fileprivate var eventTitle:String?
    
    //MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        self.setupView()
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
    override func viewWillAppear(_ animated: Bool) {
        self.setupObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        //remove observer to prevent memory leak
        self.removeObserver()
    }


    
    //MARK: Private method
    
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(CalendarViewController.orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    fileprivate func removeObserver() {
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
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
        self.collectionView.backgroundColor = AppTheme().mainColor()
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        self.setupConstraints()
      
    }
    
    fileprivate func getCalendarSectionObjects() {
        
        self.calendarViewObjects = [ListDiffable]()
        //options
        var options:Array = [Any]()
        
        options.append(ModuleOption.init(WithName: "Week", photo: UIImage.init(named: "placeholder_face"))!)
        options.append(ModuleOption.init(WithName: "Month", photo: UIImage.init(named: "calendar"))!)
        //store in the global array as a ListDiffableArray type
        self.calendarViewObjects.append(ListDiffableArray.init(withArray: options))
        
        //Event title
        updateEventSection()
        self.calendarViewObjects.append(self.eventTitle! as ListDiffable)
        
        //EVENT LIST TESTING
        var eventOptions:Array = [Event]()
        eventOptions.append(Event.init(WithName: "Shopping", icon: GlobalImages().eventIconOpen())!)
        eventOptions.append(Event.init(WithName: "Pooping", icon: GlobalImages().eventIconImportant())!)
        self.calendarViewObjects.append(ListDiffableArray.init(withArray: eventOptions))
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    //updates the title and content depending on calendar view
    fileprivate func updateEventSection() {
        if (self.calendar.scope == .week) { self.eventTitle = "Events This Week" }
        else { self.eventTitle = "Events This Month" }
    }
    
    
    //MARK: - objc Methods
    @objc func orientationDidChange() {
        print("Orientation changed")
        self.calendar.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
        }
        self.adapter.reloadData(completion: nil)
    }
    @objc func buttonAdd_touchUpInside(sender: UIBarButtonItem) {
        print("Add Event View")
        let destinationVC = AddEventViewController()
        destinationVC.selectedDates = self.calendar.selectedDates
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }

    //MARK: Delegate Method
    
    //MARK: CalendarEventSectionDelegate
    func didSelectEventOptionItem(item:Event) {
        
    }
    //MARK: CalendarOptionSectionControllerDelegate
    func didSelectCalendarOptionItem(item: ModuleOption) {
        print(item.name!)
        if (item.name!.lowercased() == "week") { self.calendar.setScope(.week, animated: true) }
        else { self.calendar.setScope(.month, animated: true) }
        self.getCalendarSectionObjects()
        self.adapter.reloadData(completion: nil)
    }
    
    //MARK: FSCalendarDelegate
    
    //Tells the delegate a date in the calendar is deselected by tapping.
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //remove button
        if (self.calendar.selectedDates.count == 0){self.navigationItem.rightBarButtonItem = nil}
        print("Deselect Date \(date)")
    }
    // Tells the delegate a date in the calendar is selected by tapping.
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected Date \(date)")
        //add button
        self.navigationItem.rightBarButtonItem = self.addButton
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    //needs to update frame when hiding/showing week-month view
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        //update event section
        self.getCalendarSectionObjects()
        self.adapter.reloadData(completion: nil)
        self.view.layoutIfNeeded()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
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
        
        //Calendar view option
        if (object is ListDiffableArray && (object as! ListDiffableArray).array![0] is ModuleOption) {
            let sectionController:EmbeddedSectionController = EmbeddedSectionController()
            sectionController.delegate = self
            return sectionController
        }
        else if (object is String) {
            let sectionController:LabelSectionController = LabelSectionController()
            return sectionController
        }
        else {//Event option
            let sectionController:CalendarEventSectionController = CalendarEventSectionController()
            sectionController.delegate = self
            return sectionController
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
