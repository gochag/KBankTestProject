//
//  CheckoutViewModel.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 03.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

class CheckoutViewModel:CheckoutViewModelProtocol{
   
    let provider:ProviderData
    
    init(provider:ProviderData) {
        self.provider = provider
    }
    
    var updateView: ((ProviderData) -> Void)?
    var updatedFields: ((CheckoutFieldType) -> Void)?
    
    func fetchData(){
        updateView?(provider)
    }
    
    func checkRequireFields(_ num: String?, _ amount: String?) {
        var numBool = false
        var amountBool = false
        
        if num?.isEmpty ?? true{
            numBool = true
            updatedFields?(.number)
        }
        
        if amount?.isEmpty ?? true{
           amountBool = true
           updatedFields?(.amount)
        }
        
        if !(numBool && amountBool){
            updatedFields?(.success)
        }
    }
}
