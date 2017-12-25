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
    lazy var collectionView:UICollectionView = {
        let wrapper = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        wrapper.alwaysBounceHorizontal = true
        return wrapper
    }()
    //MARK: Private Variable
    lazy private var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_regular(), size: 17)
        label.textColor = AppTheme().textColor()
        return label
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
    
    //MARK: Public Method
    func updateView() {
        self.collectionView.backgroundColor = UIColor.magenta
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //image
        if let _ = self.image {
            self.collectionView.addSubview(self.imageView)
            self.imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.collectionView)
                make.centerX.equalTo(collectionView)
                make.width.equalTo(40)
                make.height.equalTo(40)
            })
        }
       
        //text
        self.collectionView.addSubview(self.label)
        self.label.snp.makeConstraints({ (make) in
            make.centerY.equalTo(self.collectionView)
            make.left.equalTo(15)
        })
    }
    
    //MARK: UICollectionViewCell
    override var isHighlighted: Bool {
        didSet {
            self.contentView.backgroundColor = isHighlighted ? AppTheme().secondaryColor() : nil
        }
    }
    
}
