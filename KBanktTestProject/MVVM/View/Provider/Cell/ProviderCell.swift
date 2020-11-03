//
//  ProviderCell.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PromiseKit

class ProviderCell:UITableViewCell{
    
    static let ID = "ProviderCell"
    private let icon = UIImageView()
    private let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        
        icon.autoSetDimensions(to: CGSize(width: 35, height: 35))
        icon.autoAlignAxis(toSuperviewAxis: .horizontal)
        icon.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(named: "ic_maneybox")
        
        title.autoPinEdge(.left, to: .right, of: icon, withOffset: 16)
        title.autoPinEdge(toSuperviewEdge: .right)
        title.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        title.font = UIFont.neuzeitReg()
        title.text = "Title asdas asdsd"
    }
    
    func updateCell(_ provider:ProviderData, image:UIImage?){
        self.title.text = provider.name
        self.icon.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
