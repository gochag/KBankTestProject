//
//  Repository.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation
import CoreData
import PromiseKit

protocol RepositoryProtocol {
    func save() -> Promise<Void>
    func remove() -> Promise<Void>
    func fetchAll() -> Promise<[CategoryData]>
}

class Repository : RepositoryProtocol{

    let dataManager:CoreDataManager
    
    init(_ coreDataManager:CoreDataManager) {
        self.dataManager = coreDataManager
    }
    
    func save() -> Promise<Void> {
        return Promise{ seal in
            
            
            return seal.fulfill(())
        }
    }
    

    func remove() -> Promise<Void> {
        return Promise{ seal in
            
            return seal.fulfill(())
        }
    }
    
    func fetchAll() -> Promise<[CategoryData]> {
        return Promise{ seal in
            let context = dataManager.persistentContainer.viewContext
            let fetchReuqest = NSFetchRequest<Category>(entityName: "Customer")
            
            do{
                let result = try context.fetch(fetchReuqest)
                
            }catch{
                
            }
            
            let category = [CategoryData]()
            return seal.fulfill(category)
        }
    }
    
    
}
