//
//  SideMenuHeaderCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/23/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit

class SideMenuHeaderCollectionViewCell: UICollectionViewCell {
    
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
            self.imageView.image = newValue?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    //MARK: Private Var
    fileprivate var revealWidth:CGFloat?
    fileprivate var wrapper:UIView = {
       let wrapper = UIView()
        return wrapper
    }()
    lazy private var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_bold(), size: 20)
        label.textColor = AppTheme().textColor()
        return label
    }()
    fileprivate var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = AppTheme().textColor()
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
            
            //image
            wrapper.addSubview(self.imageView)
            self.imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(wrapper)
                make.centerX.equalTo(wrapper)
                make.width.equalTo(40)
                make.height.equalTo(40)
            })
            //text
            wrapper.addSubview(self.label)
            print("DEBUG:\n" + wrapper.subviews.description)
            self.label.snp.makeConstraints({ (make) in
                make.top.equalTo(self.imageView.snp.bottom)
                make.centerX.equalTo(wrapper)
            })
            
        }
    }
    
}
