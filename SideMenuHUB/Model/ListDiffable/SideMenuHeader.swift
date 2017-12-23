//
//  SideMenuHeader.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class SideMenuHeader: NSObject, ListDiffable {
    
    
    var name:String?
    
    override init() {
        super.init()
    }
    
    //MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self.name! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return (self.diffIdentifier() === (object!.diffIdentifier()))
    }
    

}
