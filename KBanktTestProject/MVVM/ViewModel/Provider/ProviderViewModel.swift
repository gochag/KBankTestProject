//
//  ProviderViewModel.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

class ProviderViewModel: ProviderViewModelProtocol{
    var updateView: ((ViewData<CategoryData>) -> Void)?
    
    let category:CategoryData
    
    init(category:CategoryData) {
        self.category = category
    }
    
    func featchData() {
        self.updateView?(.success(category))
    }
}
