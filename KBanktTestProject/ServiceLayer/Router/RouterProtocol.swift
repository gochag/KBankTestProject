//
//  RouterProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController : UINavigationController? { get set }
    var builder:Builder? {get set}
}

protocol RouterProtocol : RouterMain{
    func initialViewController()
    func popToRoot()
    func openProvider(category:CategoryData)
    func openCheckout(_ provider:ProviderData)
    func openPayment()
    func openReceipt()
}
