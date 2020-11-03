//
//  Amount.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import SwiftyJSON

class AmountData{
    var value:String
    var currency:String

    init(_ json:JSON) {
        self.value = json["value"].stringValue
        self.currency = json["currency"].stringValue
    }
}
