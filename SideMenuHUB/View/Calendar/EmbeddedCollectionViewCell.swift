//
//  EmbeddedCollectionViewCell.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/24/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit

class EmbeddedCollectionViewCell: UICollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
//        view.layer.borderWidth = 1
//        view.layer.borderColor = AppTheme().mainColor().cgColor
        return view
    }()
    
    //MARK: Public Method
    func updateView() {
        
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
