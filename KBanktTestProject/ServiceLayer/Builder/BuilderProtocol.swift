//
//  BuilderProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
    func initCategoryController(_ rourer:Router) -> CategoryViewController
    func initProviderController(_ rourer: Router, category:CategoryData) -> ProviderViewController
    func initCheckoutController(_ router: Router, provider:ProviderData) -> CheckoutController
    func initPaymentController(_ rourer:Router) -> PaymentViewController
    func initReceiptController(_ rourer:Router) -> ReceiptController
}
