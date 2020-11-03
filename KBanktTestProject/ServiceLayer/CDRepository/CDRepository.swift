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

enum CDRepositoryError:Error{
    case SaveError
    case clearAllError
}

protocol CDRepositoryProtocol {
    func save(categoryData:[CategoryData]) -> Promise<[CategoryData]>
    func remove() -> Promise<Void>
    func fetchAll() -> Promise<[CategoryData]>
}

class CDRepository : CDRepositoryProtocol{
    
    let dataManager:CoreDataManager
    
    init(_ coreDataManager:CoreDataManager) {
        self.dataManager = coreDataManager
    }
    
    func save(categoryData:[CategoryData]) -> Promise<[CategoryData]> {
        return Promise{ seal in
            
            let context = dataManager.persistentContainer.viewContext
            categoryData.forEach { data in
                
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", data.id)
                
                do{
                    let categoryList = try context.fetch(request)
                    if categoryList.isEmpty{
                        let newCategory = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as! Category
                        newCategory.id = data.id
                        newCategory.name = data.name
                        
                        data.providers.forEach { providerData in
                            let newProvider = NSEntityDescription.insertNewObject(forEntityName: "Provider", into: context) as! Provider
                            newProvider.id = providerData.id
                            newProvider.name = providerData.name
                            newProvider.category = newCategory
                            newCategory.addToProviders(newProvider)
                            
                            providerData.fields.forEach { fieldData in
                                let newField = NSEntityDescription.insertNewObject(forEntityName: "CustomField", into: context) as! CustomField
                                newField.id = fieldData.id
                                newField.label = fieldData.label
                                newField.type = Int16(fieldData.type)
                                newField.provider = newProvider
                                newProvider.addToFields(newField)
                                
                                if fieldData.type == 4 {
                                    fieldData.options.forEach { pairData in
                                        let newPair = NSEntityDescription.insertNewObject(forEntityName: "Pair", into: context) as! Pair
                                        
                                        newPair.k = pairData.key
                                        newPair.v = pairData.value
                                        newPair.field = newField
                                        newField.addToOptions(newPair)
                                    }
                                }
                            }
                        }
                    }
                }catch{
                    return seal.reject(CDRepositoryError.SaveError)}
            }
            
            dataManager.saveContext()
            return seal.fulfill(categoryData)
        }
    }
    
    func remove() -> Promise<Void> {
        return Promise{ seal in
            let context = dataManager.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do{
                try context.execute(deleteRequest)
                return seal.fulfill(())
            }catch let error{
                return seal.reject(error)
            }
        }
    }
    
    func fetchAll() -> Promise<[CategoryData]> {
        return Promise{ seal in
            let context = dataManager.persistentContainer.viewContext
            let fetchReuqest = NSFetchRequest<Category>(entityName: "Category")
            
            do{
                let result = try context.fetch(fetchReuqest)
                let data = result.map{CategoryData($0)}
                return seal.fulfill(data)
            }catch let error{
                return seal.reject(error)
            }
        }
    }
    
    
}
