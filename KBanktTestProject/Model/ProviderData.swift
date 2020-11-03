//
//  Provider.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProviderData{
    var id:String
    var name:String
    var fields:[CustomFieldData]
    
    init(_ json:JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        fields = json["fields"].arrayValue.map{CustomFieldData($0)}
    }
    
    init(_ provider:Provider) {
        self.id = provider.id ?? ""
        self.name = provider.name ?? ""
        self.fields = provider.fields?.map{CustomFieldData($0 as! CustomField)} ?? [CustomFieldData]()
    }
}
