//
//  AddEventCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/27/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SnapKit

class AddEventCollectionViewCell: UICollectionViewCell {
    
    //MARK: Public Variable
    var name:String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }
    var icon:UIImage? {
        get {
            return self.imageView.image
        }
        set {
            self.imageView.image = newValue
        }
    }
    var userText:String? {
        get {
            return self.inputText.text
        }
    }
    //MARK: Private Variable
    lazy fileprivate var leftWrapper:UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = UIColor.clear
        return wrapper
    }()
    lazy fileprivate var rightWrapper:UIView = {
        let wrapper = UIView()
        wrapper.backgroundColor = UIColor.clear
        return wrapper
    }()
    lazy fileprivate var label:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: AppTheme().mainFont_regular(), size: 15)
        label.textColor = AppTheme().textColor()
        return label
    }()
    lazy fileprivate var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy fileprivate var inputText:UITextField = {
       let inputText = UITextField()
        inputText.textColor = UIColor.white
        return inputText
    }()
    lazy fileprivate var textFieldBorder:UIView = {
       let border = UIView()
        border.layer.borderWidth = 1
        border.layer.borderColor = UIColor.white.cgColor
        return border
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
        
        self.contentView.addSubview(self.leftWrapper)
        self.leftWrapper.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(110)
        }
        self.contentView.addSubview(self.rightWrapper)
        self.rightWrapper.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftWrapper.snp.right).offset(10)
            make.right.top.bottom.equalToSuperview()
        }
        //image
        
        //label
        self.leftWrapper.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        //textInputBorder
        self.rightWrapper.addSubview(self.textFieldBorder)
        self.textFieldBorder.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
        //textInput
        self.textFieldBorder.addSubview(self.inputText)
        self.inputText.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.bottom.right.equalToSuperview()
        }
        
    }
}
