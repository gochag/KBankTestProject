//
//  NetworkService.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Alamofire

class NetworkService:NetworkServiceProtocol{
    
    func getLocalCategorys() -> Promise<[CategoryData]> {
        return Promise{ seal in
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) {
                let path = Bundle.main.path(forResource: "categorys", ofType: "json")
                guard let filePath = path else {return}
                let url = URL(fileURLWithPath: filePath)
                
                do{
                    let data = try Data(contentsOf: url)
                    let categorys = try JSON(data: data).arrayValue.map{CategoryData($0)}
                    seal.fulfill(categorys)
                }catch{
                    seal.reject(NetworkError.NOT_FOUND)
                }
            }
        }
    }
    
    func getPaymentCategories() -> Promise<[CategoryData]>{
        return Promise{ seal in
            AF.request("https://pastebin.com/raw/C9pXGs7h").responseJSON { response in
                let data = response.data
                do{
                    let categorys = try JSON(data: data!).arrayValue.map{CategoryData($0)}
                    seal.fulfill(categorys)
                }catch let error{
                    seal.reject(error)
                }
            }
        }
    }
    
    func getReceipt() -> Promise<ReceiptData>{
        return Promise{ seal in
            AF.request("https://pastebin.com/raw/yaqwHatv").responseJSON { response in
                let data = response.data
                do{
                    let recept = try ReceiptData(JSON(data: data!))
                    seal.fulfill(recept)
                }catch let error{
                    seal.reject(error)
                }
            }
            
        }
    }
}
