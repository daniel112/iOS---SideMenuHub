//
//  CalendarOptionCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/24/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit

class CalendarOptionCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Variable
    var name:String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    var image:UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    
    //MARK: Private Variable
    lazy fileprivate var wrapper:UIView = {
        let wrapper = UIView()
        wrapper.layer.borderWidth = 1
        wrapper.layer.borderColor = UIColor.black.cgColor
        return wrapper
    }()
    lazy fileprivate var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_regular(), size: 17)
        label.textColor = AppTheme().textColor()
        return label
    }()
    lazy fileprivate var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        self.wrapper.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.wrapper)
        self.wrapper.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //image
        if let _ = self.image {
            self.wrapper.addSubview(self.imageView)
            self.imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.wrapper)
                make.centerX.equalTo(self.wrapper)
                make.width.equalTo(40)
                make.height.equalTo(40)
            })
        }
       
        //text
        self.wrapper.addSubview(self.label)
        self.label.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.wrapper)
            make.left.equalTo(15)
        })
    }

    
}
