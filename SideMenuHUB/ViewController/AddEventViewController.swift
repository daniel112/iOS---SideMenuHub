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
class AddEventViewController: BaseViewController, FSCalendarDelegate, FSCalendarDataSource, ListAdapterDataSource, AddEventSectionControllerDelegate {

    //MARK: Public Variable
    var selectedDates = [Date]()
    
    //MARK: Private Variable
    fileprivate var scrollView:UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    fileprivate var activeTextField: UITextField?
    fileprivate var eventQuestions:Array = [ListDiffable]()
    fileprivate var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.allowsMultipleSelection = true
        calendar.backgroundColor = UIColor.white
        calendar.clipsToBounds = true //hide top-bottom border
        return calendar
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
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.setupView()
        self.getEventQuestions()

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
        self.removeObserver()
    }
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
    }
    
    fileprivate func getEventQuestions() {
        var options:Array = [Any]()
        
        options.append(EventInputText.init(WithLabel: "Event Name", icon: nil, userText: nil)!)
        options.append(EventInputText.init(WithLabel: "Location", icon: nil, userText: nil)!)
        options.append(EventInputText.init(WithLabel: "Time", icon: nil, userText: nil)!)
        //store in the global array as a ListDiffableArray type
        self.eventQuestions.append(ListDiffableArray.init(withArray: options))
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    fileprivate func setupView() {
       
        self.view.addSubview(self.scrollView)
        self.scrollView.backgroundColor = UIColor.red
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
         //Calendar
        self.scrollView.addSubview(self.calendar)
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.calendar.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.top.left.equalToSuperview()
        })
        for date in self.selectedDates {
            self.calendar.select(date)
        }
        //navigation title
        self.navigationController?.title = "Add Event"
        
        //collectionView
        self.scrollView.addSubview(self.collectionView)
        self.collectionView.backgroundColor = AppTheme().mainColor()
        self.collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.calendar.snp.bottom)
            make.left.bottom.right.equalTo(self.view)
        })
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
       
    }
    //MARK: - objc Methods
    @objc func orientationDidChange() {
        calendar.snp.updateConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
        }
        //self.adapter.reloadData(completion: nil)
    }
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        
        if let activeTextField = self.activeTextField {
            let info: NSDictionary = notification.userInfo! as NSDictionary
            let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
            let keyboardSize: CGSize = value.cgRectValue.size
            let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets

            //adjust scrollview
            var keyboardRect: CGRect = self.view.frame
            keyboardRect.size.height -= keyboardSize.height
            let activeTextFieldRect: CGRect? = self.view.convert(activeTextField.frame, from: activeTextField.superview)
            let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
            if (keyboardRect.size.height < activeTextFieldOrigin!.y + activeTextFieldRect!.size.height) {
                let scrollPoint = CGPoint(x: 0.0, y: activeTextFieldOrigin!.y - (keyboardSize.height + 200))
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }

        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    //MARK: AddEventSectionControllerDelegate
    func textFieldIsSelected(activeTextField: UITextField) {
        self.activeTextField = activeTextField
        let frame = self.view.convert(activeTextField.frame, from: activeTextField.superview)
        print("frame from controller: \(frame)")
    }
    
    
    //MARK: FSCalendarDelegate
    
    //needs to update frame when hiding/showing week-month view
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        //update event section
       // self.getCalendarSectionObjects()
        self.adapter.reloadData(completion: nil)
        self.view.layoutIfNeeded()
    }
    
    //Asks the delegate whether the specific date is allowed to be selected by tapping.
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    //MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.eventQuestions
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let sectionController:AddEventSectionController = AddEventSectionController()
        sectionController.delegate = self
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
