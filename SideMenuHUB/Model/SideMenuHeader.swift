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
    var image:UIImage?
    
    init?(withName name:String, image:UIImage?) {
        self.name = name
        self.image = image
    }
    
    //MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return self.name! as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self.name! == (object!.diffIdentifier() as! String)
    }
    

}
