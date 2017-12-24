//
//  ListDiffableArray.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class ListDiffableArray: NSObject, ListDiffable  {
    
    var identifier:String?
    var array:Array<Any>?
    
    override init() {
        super.init()
        identifier = UUID().uuidString
        
        
    }
    init(withArray array:Array<Any>) {
        
        super.init()
        identifier = UUID().uuidString
        self.array = array
        
        
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.identifier! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.diffIdentifier() === object!.diffIdentifier()
    }
    

}
