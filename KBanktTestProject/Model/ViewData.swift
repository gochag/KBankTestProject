//
//  ResultData.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

enum ViewData<T>{
    case loading
    case success(T)
    case error(Error)
}
