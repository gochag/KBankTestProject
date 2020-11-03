//
//  Category.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class CategoryData{
    
    var id:String
    var name:String
    var providers:[ProviderData]
    
    init(_ json:JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.providers = json["providers"].arrayValue.map{ProviderData($0)}
    }
    
    init(_ category:Category) {
        self.id = category.id ?? ""
        self.name = category.name ?? ""
        self.providers = category.providers?.map{ProviderData($0 as! Provider)} ?? [ProviderData]()
    }
}
