//
//  Receipt.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class ReceiptData{
    var id:String
    var date:String
    var details:[PairData]
    var amount:[AmountData]
    
    init(_ json:JSON) {
        self.id = json["id"].stringValue
        self.date = json["date"].stringValue
        self.details = json["details"].arrayValue.map{PairData($0)}
        self.amount = json["amount"].arrayValue.map{AmountData($0)}
    }
}
