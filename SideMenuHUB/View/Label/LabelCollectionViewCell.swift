//
//  LabelCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/25/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Var
    var name:String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    
    //Private Variable
    lazy private var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_bold(), size: 17)
        label.textColor = AppTheme().textColor()
        return label
    }()
    
    //MARK: Public Method
    func updateView() {
        self.contentView.addSubview(self.label)
        self.label.snp.updateConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
    }
}
