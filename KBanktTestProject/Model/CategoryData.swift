//
//  Category.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoryData:KData{
    
    var id:Int
    var name:String
    var providers:[ProviderData]
    
    init(_ json:JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.providers = json["providers"].arrayValue.map{ProviderData($0)}
    }
}
