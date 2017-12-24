//
//  SideMenuOptionCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit

class SideMenuOptionCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Var
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
    
    //MARK: Private Var
    fileprivate var revealWidth:CGFloat?
    lazy private var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_regular(), size: 17)
        label.textColor = AppTheme().textColor()
        return label
    }()
    fileprivate var wrapper:UIView = {
        let wrapper = UIView()
        return wrapper
    }()
    fileprivate var imageView:UIImageView = {
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
    func updateWithRevealWidth(revealWidth:CGFloat) {
        
        if (self.revealWidth != revealWidth) {
            
            self.revealWidth = revealWidth
            
            self.contentView.addSubview(wrapper)
            wrapper.snp.makeConstraints({ (make) in
                make.top.left.equalTo(self.contentView)
                make.width.equalTo(revealWidth)
                make.height.equalTo(self.contentView.frame.height)
            })

            //IMAGE
            wrapper.addSubview(self.imageView)
            self.imageView.snp.makeConstraints({ (make) in
                make.width.equalTo(40)
                make.height.equalTo(40)
                make.centerY.equalTo(wrapper)
                make.leadingMargin.equalTo(15)
            })
            
            //TEXT
            //center y and 10 pixel from imageview
            wrapper.addSubview(self.label)
            self.label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(wrapper)
                make.left.equalTo(self.imageView.snp.right).offset(10)
            })
            
        }
    }
    
    
    
}
