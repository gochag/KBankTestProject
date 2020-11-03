//
//  CategoryViewModel.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import PromiseKit

class CategoryViewModel:CategoryViewModelProtocol{

    var updateCategories: ((ViewData<[CategoryData]>) -> ())?
    
    var businessLayer:CategoryBusinessLogic!
    
    func loadData() {
        if Connection.isConnectedToNetwork(){
            firstly { () -> Promise<[CategoryData]> in
                self.updateCategories?(.loading)
                return self.businessLayer.requestLoadCategory()
            }.done { [weak self] categorys in
                self?.updateCategories?(.success(categorys))
            }.catch { error in
                self.updateCategories?(.error(error))
            }
        } else {
            businessLayer.loadCachedCategory()
                .done {[weak self] categorys in
                    if categorys.isEmpty{
                        self?.updateCategories?(.error(CategoryError.NoInternet))
                    }else{
                        self?.updateCategories?(.error(CategoryError.NoInternetCacheSaved))
                    }
            }.catch { error in
                 self.updateCategories?(.error(error))
            }
        }
        
    }
    
    func loadCacheData() {
        businessLayer.loadCachedCategory()
            .done {[weak self] categorys in
                self?.updateCategories?(.success(categorys))
        }.catch { error in
            self.updateCategories?(.error(error))
        }
    }
    
    private func isConnectedToNetwork() -> Bool {
        return Connection.isConnectedToNetwork()
    }
}
