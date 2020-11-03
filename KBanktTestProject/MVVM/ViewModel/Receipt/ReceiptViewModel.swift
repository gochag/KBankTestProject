//
//  ReceiptViewModel.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import PromiseKit

class ReceiptViewModel:ReceiptViewModelProtocol{
    
    var updateView: ((ReceiptData) -> Void)?
    
    let network:NetworkServiceProtocol
    
    init(network:NetworkServiceProtocol) {
        self.network = network
    }
    
    func featchData() {
        network.getReceipt().done {[weak self] receiptData in
            self?.updateView?(receiptData)
        }.catch{ error in
            print(error)
        }
    }
}
