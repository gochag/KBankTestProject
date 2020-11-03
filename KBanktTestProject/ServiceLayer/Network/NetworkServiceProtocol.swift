//
//  NetworkServiceProtocol.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import PromiseKit

protocol NetworkServiceProtocol{
    func getLocalCategorys() -> Promise<[CategoryData]>
    func getPaymentCategories() -> Promise<[CategoryData]>
    func getReceipt() -> Promise<ReceiptData>
}

enum NetworkError:Error{
    case NOT_FOUND
}
