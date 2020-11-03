//
//  PairData.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 02.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class PairData{
    
    var key:String
    var value:String
    
    init(_ json:JSON) {
        key = json["k"].stringValue
        value = json["v"].stringValue
    }
    
    init(_ pair:Pair) {
        key = pair.k ?? ""
        value = pair.v ?? ""
    }
}
