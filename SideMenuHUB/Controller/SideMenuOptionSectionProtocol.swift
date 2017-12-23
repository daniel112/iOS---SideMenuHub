//
//  SideMenuOptionSectionProtocol.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/22/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import Foundation
import UIKit

//MARK: Protocols
protocol SideMenuOptionSectionItem {
    var sideMenuOptionText:String { get }
    var sideMenuOptionImage:UIImage { get set }
}
