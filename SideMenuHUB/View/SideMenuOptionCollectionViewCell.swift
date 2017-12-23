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
        label.textColor = UIColor.black
        return label
    }()
    fileprivate var imageView:UIImageView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UICollectionViewCell
    override var isSelected: Bool {
        didSet {
            //green if selected, gray if not
            self.contentView.backgroundColor = isSelected ? UIColor.green : UIColor.lightGray
        }
    }
    
    //MARK: Public Method
    func updateWithRevealWidth(revealWidth:CGFloat) {
        
        if (self.revealWidth != revealWidth) {
            
            self.revealWidth = revealWidth
            let wrapper = UIView()
            
            wrapper.backgroundColor = UIColor.green
            self.contentView.addSubview(wrapper)
            wrapper.snp.makeConstraints({ (make) in
                make.top.left.equalTo(self.contentView)
                make.width.equalTo(revealWidth)
                make.height.equalTo(self.contentView.frame.height)
            })

            //image
            
            //text
            wrapper.addSubview(self.label)
            print(wrapper.subviews.description)
            self.label.snp.makeConstraints({ (make) in
                make.centerY.equalTo(wrapper)
                make.leadingMargin.equalTo(10)
            })
            
        }
    }
    
    
    
}
