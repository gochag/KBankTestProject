//
//  CardView.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 01.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

enum CardType{
    case visa
    case master
    case maestro
    case none
}

class CardView:UIView{
    
    let expireDate = UILabel()
    let cardNumber = UILabel()
    let cardOwner = UILabel()
    let debitCard = UILabel()
    let cardIcon = UIImageView()
    
    override var intrinsicContentSize: CGSize{
        let width = UIScreen.main.bounds.width - 64
        let height = width / 2
        return CGSize(width: width, height: height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(expireDate)
        addSubview(cardNumber)
        addSubview(cardOwner)
        addSubview(debitCard)
        addSubview(cardIcon)
        
        prepareExpireDate()
        prepareCardNumber()
        prepareDebitCard()
        prepareCardOwner()
        prepareCardIcon()
    }
    
    private func prepareCardNumber(){
        cardNumber.autoAlignAxis(toSuperviewAxis: .horizontal)
        cardNumber.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        cardNumber.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        
        cardNumber.font = UIFont.neuzeitBolt(size: 28)
        cardNumber.textAlignment = .left
        cardNumber.textColor = .white
        cardNumber.text = "**** **** **** ****"
    }
    
    private func prepareDebitCard(){
        debitCard.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        debitCard.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        debitCard.autoSetDimension(.width, toSize: 100)
        
        debitCard.font = UIFont.neuzeitLight(size: 14)
        debitCard.textAlignment = .right
        debitCard.textColor = .white
        debitCard.text = "Debit card"
    }
    
    private func prepareCardOwner(){
        cardOwner.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        cardOwner.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        cardOwner.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        
        cardOwner.font = UIFont.neuzeitReg(size: 18)
        cardOwner.textAlignment = .left
        cardOwner.textColor = .white
        cardOwner.text = "Tarlan Hekimzade"
    }
    
    private func prepareExpireDate(){
        expireDate.autoPinEdge(toSuperviewEdge: .top, withInset: 32)
        expireDate.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        
        expireDate.font = UIFont.neuzeitReg(size: 18)
        expireDate.textAlignment = .right
        expireDate.textColor = .white
        expireDate.text = "11/22"
    }
    
    private func prepareCardIcon(){
        cardIcon.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        cardIcon.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        cardIcon.autoSetDimensions(to: CGSize(width: 30, height: 30))
        updateCardType(type: .none)


    }
    
    func updateCardType(type:CardType){
        switch type {
        case .visa:
            cardIcon.image = UIImage(named: "ic_visa")
        case .maestro:
            cardIcon.image = UIImage(named: "ic_maestro")
        case .master:
            cardIcon.image = UIImage(named: "ic_mastercard")
        default:
            cardIcon.image = nil
        }
        cardIcon.image? = (cardIcon.image?.withRenderingMode(.alwaysTemplate))!
        cardIcon.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
