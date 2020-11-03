//
//  CategoryCell.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

class CategoryCell: UICollectionViewCell {
    
    static let ID = "CategoryCell"

    private let icon = UIImageView()
    private let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let cornerRadius:CGFloat = 7
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        
        let cgPath = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        contentView.layer.shadowPath = cgPath
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        
        let wh = contentView.frame.width/2
        icon.autoSetDimensions(to: CGSize(width: wh, height: wh))
        icon.autoAlignAxis(toSuperviewAxis: .vertical)
        icon.autoPinEdge(toSuperviewEdge: .top, withInset: 32)
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "ic_maneybox")
        
        title.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
        title.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        title.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        title.font = UIFont.neuzeitBolt()
        title.textAlignment = .center
        title.numberOfLines = 2
        title.text = "Title title title"
    }
    
    func updateView(_ category:CategoryData, image:UIImage?){
        title.text = category.name
        icon.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

