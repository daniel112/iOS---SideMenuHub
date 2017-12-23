//
//  SideMenuViewController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit

class SideMenuViewController: UIViewController, ListAdapterDataSource,SideMenuOptionSectionControllerDelegate {
    
    //MARK: variables
    var sideMenuObjects:Array = [ListDiffable]()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = AppTheme().mainColor()
        view.alwaysBounceVertical = true
        return view
    }()
    
    override func loadView() {
        super.loadView()
        self.setupView()
        self.createSideMenuObjects()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Private Methods
    func setupView() {
        
        //collectionView
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self

        
    }
    
    func createSideMenuObjects() {
        
        //header
        let header:SideMenuHeader = SideMenuHeader.init(withName:"Daniel", image: UIImage.init(named: "placeholder_face"))!
        
        //options
        var options:Array = [Any]()
        
        options.append(ModuleOption.init(WithName: "Test", photo: UIImage.init(named: "placeholder_face"))!)
        options.append(ModuleOption.init(WithName: "Module2", photo: nil)!)
        
        //store in the global array as a ListDiffableArray type
        self.sideMenuObjects.append(header)
        self.sideMenuObjects.append(ListDiffableArray.init(withArray: options))
        self.adapter.performUpdates(animated: true, completion: nil)
        
    }
    
    //MARK: SideMenuOptionSectionControllerDelegate
    func didSelectSideMenuOptionItem(item: ModuleOption) {
        print(item.name!)
    }
    
    
    //MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        //sideMenuObjects will contain 2 section arrays (header[array], options[array])
        return self.sideMenuObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        //header
        if (object is SideMenuHeader) {
            let sectionController:SideMenuHeaderController = SideMenuHeaderController()
            sectionController.delegate = self
            sectionController.revealWidth = self.revealViewController().rearViewRevealWidth
            return sectionController
        }
        else {//options
        
            let sectionController:SideMenuOptionController = SideMenuOptionController()
            sectionController.delegate = self
            sectionController.revealWidth = self.revealViewController().rearViewRevealWidth
            return sectionController

        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
