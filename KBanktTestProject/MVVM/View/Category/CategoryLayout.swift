//
//  CategoryLayout.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

class CategoryLayout:UICollectionViewFlowLayout{
    
    let cellHeight:CGFloat = 200
    let cellWidth:CGFloat = 150
    let padding:CGFloat = 16
    
    var farInset: CGFloat {
        guard let collection = collectionView else { return .zero }
        return (collection.frame.width - cellWidth) / 2
    }
    
    var insets: UIEdgeInsets {
        UIEdgeInsets(top: .zero, left: farInset, bottom: .zero, right: farInset)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)
    }
    
    override func prepare() {
        let width = (UIScreen.main.bounds.width - 16 - 32) / 3
        itemSize = CGSize(width: width, height: width * 1.4)
        collectionView?.contentInset = UIEdgeInsets(top: 16, left: padding, bottom: 16, right: padding)
        minimumLineSpacing = 8
        minimumInteritemSpacing = 8
        super.prepare()
    }
}
