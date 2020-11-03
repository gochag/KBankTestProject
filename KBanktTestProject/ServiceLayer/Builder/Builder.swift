//
//  Builder.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

class Builder:BuilderProtocol{
    
    let network = NetworkService()
    let repository = CDRepository(CoreDataManager.instance)
    
    func initCategoryController(_ rourer: Router) -> CategoryViewController {
        let viewModel = CategoryViewModel()
        let businessLayer = CategoryBusinessLogic(network: network, repository: repository)
        viewModel.businessLayer = businessLayer
        
        let viewController = CategoryViewController()
        viewController.router = rourer
        viewController.viewModel = viewModel
        return viewController
    }
    
    func initProviderController(_ rourer: Router, category:CategoryData) -> ProviderViewController {
        let viewModel = ProviderViewModel(category: category)
        let viewController = ProviderViewController()
        viewController.router = rourer
        viewController.viewModel = viewModel
        return viewController
    }
    
    func initCheckoutController(_ router: Router, provider:ProviderData) -> CheckoutController {
        let viewController = CheckoutController()
        let viewModel = CheckoutViewModel(provider: provider)
        viewController.router = router
        viewController.viewModel = viewModel
        return viewController
    }
    
    func initPaymentController(_ rourer: Router) -> PaymentViewController {
        let viewController = PaymentViewController()
        let viewModel = PaymentViewModel()
        viewController.router = rourer
        viewController.viewModel = viewModel
        return viewController
    }
    
    func initReceiptController(_ rourer: Router) -> ReceiptController {
        let viewController = ReceiptController()
        let viewModel = ReceiptViewModel(network: network)
        viewController.router = rourer
        viewController.viewModel = viewModel
        return viewController
    }
}
