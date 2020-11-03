//
//  PaymentViewModelProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 03.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol PaymentViewModelProtocol{
    var updateCardType:((CardType)->Void)? { get set }
    var incorrectCardData:((CardWarning) -> Void)? { get set }
    func checkCardNumber(_ number:String)
    func checkExpireDate(_ strDate: String)
    func checkCvvNumber(_ number:String)
    func checkCardOwner(_ string:String)
    func checkCardData()
}

enum CardWarning{
    case number
    case expireDate
    case cvv
    case cardOwner
    case success
}
