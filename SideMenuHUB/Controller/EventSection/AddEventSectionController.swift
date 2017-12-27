//
//  AddEventSectionController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/27/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class AddEventSectionController: ListSectionController, UITextFieldDelegate {

    //MARK: Public Variable
    var delegate:Any?
    
    //MARK: Private Variable
    fileprivate var questionArray = [EventInputText]()// EventInputText & EventInputButton
    
    //MARK: ListSectionController
    override func numberOfItems() -> Int {
        return questionArray.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext!.containerSize.width, height: 60)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCell(of: AddEventCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? AddEventCollectionViewCell else {
                                                                    fatalError()
        }
        
        cell.name = self.questionArray[index].label
        cell.icon = self.questionArray[index].icon
        cell.updateView()
        return cell
        
    }
    
    override func didUpdate(to object: Any) {
        precondition(object is ListDiffableArray)
        let diffableArray:ListDiffableArray = object as! ListDiffableArray
        self.questionArray = diffableArray.array! as! [EventInputText]
    }
    
    override func didSelectItem(at index: Int) {}
    

   

}
