//
//  CheckoutViewModelProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 03.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol CheckoutViewModelProtocol {
    
    var updatedFields:((CheckoutFieldType)->Void)? {get set}
    var updateView:((ProviderData) -> Void)? {get set}
    func checkRequireFields(_ num:String?,_ amount:String?)
    func fetchData()
    
}

enum CheckoutFieldType{
    case number
    case amount
    case success
}
