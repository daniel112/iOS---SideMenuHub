//
//  ModuleOption.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit

struct ModuleOption {

    //MARK: Properties
    var image:UIImage?
    var name:String?
    
    //MARK: Initialization
    init?(WithName name: String, photo: UIImage?) {
        
        if (name.isEmpty) {
            return nil
        }
        self.name = name
        self.image = photo
    }
}
