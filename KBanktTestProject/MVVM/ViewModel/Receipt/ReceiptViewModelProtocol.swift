//
//  ReceiptViewModelProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 03.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol ReceiptViewModelProtocol {
    var updateView:((ReceiptData)->Void)? {get set}
    func featchData()
}
