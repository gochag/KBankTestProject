//
//  CategoryBusinessLogic.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import PromiseKit

class CategoryBusinessLogic{
    
    private let repository:CDRepositoryProtocol
    private let network:NetworkServiceProtocol
    
    init(network:NetworkService, repository:CDRepository) {
        self.network = network
        self.repository = repository
    }
    
    func loadAllCategory() -> Promise<[CategoryData]>{
        return repository.fetchAll()
            .then{ data -> Promise<[CategoryData]> in
                if data.isEmpty{
                    return self.network.getLocalCategorys().then{self.repository.save(categoryData: $0)}
                }else{
                    return Promise{$0.fulfill(data)}
                }
        }
    }
    
    func requestLoadCategory() -> Promise<[CategoryData]>{
        return self.network.getPaymentCategories().then{self.repository.save(categoryData: $0)}
    }
    
    func loadCachedCategory() -> Promise<[CategoryData]>{
        return repository.fetchAll()
    }
    
    func clearChacheData() -> Promise<Void>{
        return repository.remove()
    }
    

}
