//
//  Provider.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProviderData:KData{
    var id:Int
    var name:String
    var fields = [Int]()
    
    init(_ json:JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
    }
}
