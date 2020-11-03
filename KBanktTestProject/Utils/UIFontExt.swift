//
//  UIFontExt.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

extension UIFont{
    
    static func neuzeitReg(size s:CGFloat = 18) -> UIFont{
        if let neuzeFontBla = UIFont(name: "NeuzeitGro-Reg", size: s){
            return neuzeFontBla
        } else {
            return  UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        }
    }
    
    static func neuzeitBolt(size s:CGFloat = 18) -> UIFont{
        if let neuzeFontBla = UIFont(name: "NeuzeitGro-Bol", size: s){
            return neuzeFontBla
        } else {
            return  UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        }
    }
    
    static func neuzeitLight(size s:CGFloat = 18) -> UIFont{
        if let neuzeFontBla = UIFont(name: "NeuzeitGro-Lig", size: s){
            return neuzeFontBla
        } else {
            return  UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        }
    }
}
