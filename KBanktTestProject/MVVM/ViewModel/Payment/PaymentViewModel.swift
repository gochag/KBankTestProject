//
//  PaymentViewModel.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import Foundation

class PaymentViewModel:PaymentViewModelProtocol{
    var incorrectCardData:((CardWarning) -> Void)?
    var updateCardType: ((CardType) -> Void)?
    
    var cardNumber = false
    var expireDate = false
    var cvvNumber = false
    var cardOwner = false
    
    func checkCardNumber(_ number: String){
        let cardNum = number.replacingOccurrences(of: " ", with: "")

        if let firstNum = cardNum.first{
            let first = Int(String(firstNum))
            
            switch first {
            case 4:
                updateCardType?(.visa)
            case 3:
                updateCardType?(.maestro)
            case 5:
                updateCardType?(.master)
            default:
                updateCardType?(.none)
            }
        }else{
            updateCardType?(.none)
        }
        
        self.cardNumber = cardNum.count == 16
    }
    
    func checkExpireDate(_ strDate: String) {
        guard strDate.count == 5 else {return}
        let monthStr = String(strDate.split(separator: "/")[0])
        let yearStr = String(strDate.split(separator: "/")[1])

        let month = Int(monthStr)
        let year = 2000 + (Int(yearStr) ?? 0)
        
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())
        dateComponents.year = year
        dateComponents.month = month
        let date = calendar.date(from: dateComponents)

        let currentDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
                
        let foreYear = calendar.date(byAdding: .year, value: 4, to: Date())

        expireDate = !(date! < currentDate! || date! > foreYear!)
    }
    
    func checkCvvNumber(_ number:String){
        cvvNumber = number.count == 3
    }
    
    func checkCardOwner(_ string:String){
        cardOwner = !string.isEmpty
    }
    
    func checkCardData(){
        if !cardNumber{
            incorrectCardData?(.number)
        }
        if !expireDate{
            incorrectCardData?(.expireDate)

        }
        if !cvvNumber{
            incorrectCardData?(.cvv)
        }
        if !cardOwner{
            incorrectCardData?(.cardOwner)
        }
        
        if cardNumber && expireDate && cvvNumber && cardOwner{
            incorrectCardData?(.success)
        }
    }
}
