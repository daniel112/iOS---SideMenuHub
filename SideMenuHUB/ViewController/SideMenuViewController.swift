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
    var sideMenuObjects:Array = [Any]()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.lightGray
        view.alwaysBounceVertical = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createSideMenuObjects()
        self.setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Private Methods
    func setupView() {
        
        self.view.backgroundColor = UIColor.lightGray
        
        //collectionView
        view.addSubview(self.collectionView)
        
        
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
    }
    
    func createSideMenuObjects() {
        
        //options
        var options:Array = [Any]()
        
        options.append(ModuleOption.init(WithName: "Test", photo: nil)!)
        options.append(ModuleOption.init(WithName: "Module2", photo: nil)!)
        
        //store in the global array as a ListDiffableArray type
        self.sideMenuObjects.append(ListDiffableArray.init(withArray: options))
        
    }
    
    //MARK: SideMenuOptionSectionControllerDelegate
    func didSelectSideMenuOptionItem(item: ModuleOption) {
        
    }
    
    
    //MARK: ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        //sideMenuObjects will contain 2 section arrays (header[array], options[array])
        return self.sideMenuObjects as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        //header
        if (object is SideMenuHeader) {
            let sectionController:SideMenuOptionController = SideMenuOptionController()
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
