//
//  CalendarOptionSectionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/24/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class EmbeddedSectionController: ListSectionController, ListAdapterDataSource {

    //MARK: Public Variable
    var delegate:CalendarOptionSectionControllerDelegate?
    
    //MARK: Private Variable
    fileprivate var optionArray:Array = [ListDiffable]()
    
    fileprivate lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: EmbeddedCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? EmbeddedCollectionViewCell else {
                                                                    fatalError()
        }
        
        adapter.collectionView = cell.collectionView
        cell.updateView()
        
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        //break down each object into diffable object
        let diffableArray = object as! ListDiffableArray
        self.optionArray.append(diffableArray)
    }
    
    override func didSelectItem(at index: Int) {    }
    
    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.optionArray
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let sectionController = CalendarOptionSectionController()
        sectionController.width = collectionContext!.containerSize.width/2
        sectionController.delegate = self.delegate
        return sectionController
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
