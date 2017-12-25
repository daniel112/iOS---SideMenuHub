//
//  Calendar.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/24/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import Foundation
import IGListKit

class CalendarConfig: NSObject, ListDiffable {
    //MARK: Properties
    var height:CGFloat?
    var backgroundColor:UIColor?
    var clipsToBound:Bool?
    var allowMultiSelect:Bool?
    
    fileprivate var identifier:String?
    
    //MARK: Initialization
    override init() {
        super.init()
        identifier = UUID().uuidString
    }
    init(WithProperties height:CGFloat?, backgroundColor:UIColor?, clipsToBound:Bool?, allowMultiSelect:Bool?) {
        super.init()
        identifier = UUID().uuidString
        self.height = height
        self.backgroundColor = backgroundColor
        self.clipsToBound = clipsToBound
        self.allowMultiSelect = allowMultiSelect
    }
    
    //MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.diffIdentifier() === object!.diffIdentifier()
    }
}
