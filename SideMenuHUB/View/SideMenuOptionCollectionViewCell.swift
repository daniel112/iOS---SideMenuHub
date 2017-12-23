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
    
    var name:String?
    var image:UIImage?
    private var revealWidth:CGFloat?
    private var label:UILabel {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.clear
        lbl.font = UIFont.systemFont(ofSize: 17)
        return lbl
    }
    private var imageView:UIImageView?
    
     init() {
        super.init(frame: CGRect.zero)
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
            
            let wrapper = UIView()
            wrapper.backgroundColor = UIColor.red
            self.contentView.addSubview(wrapper)
            wrapper.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            
            //image
            
            //text
            wrapper.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.top.bottom.equalToSuperview()
                make.leadingMargin.equalTo(10)
            })
            
        }
    }
    
    
    
}
