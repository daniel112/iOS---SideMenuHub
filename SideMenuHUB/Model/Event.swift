//
//  Event.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/25/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit

struct Event {

    //MARK: Public Properties
    var name:String?
    var participants:Array<String>?
    var icon:UIImage?
    
    //MARK: Initialization
    init?(WithName name: String, icon: UIImage?) {
        
        if (name.isEmpty) {
            return nil
        }
        self.name = name
        self.icon = icon
    }
}
