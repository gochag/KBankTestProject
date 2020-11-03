//
//  CategoryViewModelProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 03.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

protocol CategoryViewModelProtocol {
    var updateCategories:((ViewData<[CategoryData]>) -> ())? { get set }
    func loadData()
    func loadCacheData()
}

enum CategoryError:Error{
    case NoInternetCacheSaved
    case NoInternet
}
