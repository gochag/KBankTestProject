//
//  Router.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

class Router:RouterProtocol{
    
    var navigationController: UINavigationController?
    
    var builder: Builder?
    
    init(navigationController: UINavigationController, builder: Builder) {
           self.navigationController = navigationController
           self.builder = builder
    }
    
    func popToRoot(){
        if let navigationController = navigationController{
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    func initialViewController() {
        if let navigationController = navigationController{
            guard let controller = builder?.initCategoryController(self) else {return }
            navigationController.viewControllers = [controller]
        }
    }
    
    func openProvider(category:CategoryData) {
        if let navigationController = navigationController{
            guard let controller = builder?.initProviderController(self, category: category) else {return}
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func openCheckout(_ provider:ProviderData) {
        if let navigationController = navigationController{
            guard let controller = builder?.initCheckoutController(self,provider: provider) else {return}
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func openPayment() {
        if let navigationController = navigationController{
            guard let controller = builder?.initPaymentController(self) else {return}
            navigationController.pushViewController(controller, animated: true)
        }
    }
    
    func openReceipt() {
        if let navigationController = navigationController{
            guard let controller = builder?.initReceiptController(self) else {return}
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
