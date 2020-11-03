//
//  CustomField.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class CustomFieldData{
    var id:String
    var type:Int
    var label:String
    var options:[PairData]
    
    init(_ json:JSON) {
        self.id = json["id"].stringValue
        self.type = json["type"].intValue
        self.label = json["label"].stringValue
        self.options = json["options"].arrayValue.map{PairData($0)}
    }

    init(_ field : CustomField) {
        self.id = field.id ?? ""
        self.label = field.label ?? ""
        self.type = Int(field.type)
        self.options = field.options?.map{PairData($0 as! Pair)} ?? [PairData]()
    }
}
