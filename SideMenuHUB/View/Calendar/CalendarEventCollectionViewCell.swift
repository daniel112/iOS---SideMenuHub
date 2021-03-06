//
//  CalendarEventCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/25/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit

class CalendarEventCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Variables
    var name:String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    var participants:Array<String>?
    var icon:UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    //MARK: Private Variables
    lazy fileprivate var lineView:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.black
       return line
    }()
    

    lazy fileprivate var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_regular(), size: 17)
        label.textColor = AppTheme().textColor()
        return label
    }()
    lazy fileprivate var subLabel:UILabel = {
        let subLabel = UILabel()
        subLabel.backgroundColor = .clear
        subLabel.font = UIFont(name: AppTheme().mainFont_regular(), size: 10)
        subLabel.textColor = AppTheme().textColor()
        subLabel.text = String(describing: self.participants?.count) + " participant(s)"
        return subLabel
    }()
    lazy fileprivate var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy fileprivate var wrapper:UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = .clear
        return wrapper
    }()
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UICollectionViewCell
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? AppTheme().secondaryColor() : nil
        }
    }
    
    //MARK: Public Method
    func updateView() {
        
        self.contentView.addSubview(self.wrapper)
        self.wrapper.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //image
        if let _ = self.icon {
            self.wrapper.addSubview(self.imageView)
            self.imageView.snp.makeConstraints({ (make) in
                make.centerY.equalTo(self.wrapper)
                make.width.equalTo(24)
                make.height.equalTo(24)
            })
        }
        //label
        self.wrapper.addSubview(self.label)
        self.label.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
        }
        //subLabel
        if self.participants?.count == 0 || self.participants == nil {
            self.subLabel.text = ""
        }
        self.wrapper.addSubview(self.subLabel)
        self.subLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.label.snp.bottom)
            make.bottom.equalTo(self.wrapper)
            make.centerX.equalToSuperview()
        }
        //nav icon right
        let navIcon = UIImage.init(named: "nav_icon_right")
        let navImageView = UIImageView.init(image: navIcon)
        self.wrapper.addSubview(navImageView)
        navImageView.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        //bottom border
        self.wrapper.addSubview(self.lineView)
        self.lineView.snp.updateConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            //make.top.equalTo(self.subLabel.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
    }
}
