//
//  TextFieldWithHeader.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

class TextFieldWithHeader:UIView{
    
    let header = UILabel()
    let editText = CustomTextField()
    let warning = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(header)
        addSubview(editText)
        addSubview(warning)
        
        header.autoPinEdge(toSuperviewEdge: .top)
        header.autoPinEdge(toSuperviewEdge: .left)
        header.autoPinEdge(toSuperviewEdge: .right)
        header.font = UIFont.neuzeitReg()
        
        editText.autoPinEdge(toSuperviewEdge: .left)
        editText.autoPinEdge(toSuperviewEdge: .right)
        editText.autoPinEdge(toSuperviewEdge: .bottom)
        editText.autoPinEdge(.top, to: .bottom, of: header, withOffset: 8)
        
        editText.inset = 16
        editText.layer.borderColor = UIColor.blue.cgColor
        editText.layer.borderWidth = 1
        editText.layer.cornerRadius = 7
        
        warning.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        warning.autoAlignAxis(.horizontal, toSameAxisOf: editText)
        warning.autoSetDimensions(to: CGSize(width: 20, height: 20))
        
        warning.layer.cornerRadius = 10
        warning.backgroundColor = .red
        warning.text = "!"
        warning.textAlignment = .center
        warning.textColor = .white
        warning.clipsToBounds = true
        warning.isHidden = true
    }
    
    func showWarning(){
        warning.isHidden = false
    }
    
    func hideWarning(){
        warning.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTextField: UITextField {
    
    var inset: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
