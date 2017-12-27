//
//  EventInputText.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/27/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import Foundation

struct EventInputText {
    
    //MARK: Public Properties
    var label:String?
    var icon:UIImage?
    var userText:String?
    
    //MARK: Initialization
    init?(WithLabel label: String, icon: UIImage?, userText:String?) {
        
        self.label = label
        self.icon = icon
        self.userText = userText
    }
}
