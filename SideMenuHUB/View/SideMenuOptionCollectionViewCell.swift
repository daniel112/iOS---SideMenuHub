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
            return self.imageView?.image
        }
        set {
            self.imageView?.image = newValue
        }
    }
    
    //MARK: Private Var
    fileprivate var revealWidth:CGFloat?
    lazy private var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 17)
        label.textColor = AppTheme().textColor()
        return label
    }()
    fileprivate var wrapper:UIView = {
        let wrapper = UIView()
        return wrapper
    }()
    fileprivate var imageView:UIImageView?

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

            //image
            
            //text
            wrapper.addSubview(self.label)
            self.label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(wrapper)
                make.leadingMargin.equalTo(10)
            })
            
        }
    }
    
    
    
}
