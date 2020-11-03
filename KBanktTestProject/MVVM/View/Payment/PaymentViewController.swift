//
//  PaymentViewController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit

class PaymentViewController: BaseViewController{
    
    var viewModel:PaymentViewModelProtocol!
    var router:Router!
    
    private let intputView = UIView()
    private let cardView = CardView()
    private let cardNumber = TextFieldWithHeader()
    private let expireView = TextFieldWithHeader()
    private let cvvView = TextFieldWithHeader()
    private let cardOwnerView = TextFieldWithHeader()
    
    private let priceView = UIView()
    private let price = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initIntputView()
        initCardView()
        initPriceView()
        
        updateCardType()
        checkCardData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        priceView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    private func initCardView(){
        view.addSubview(cardView)
        
        cardView.autoAlignAxis(toSuperviewAxis: .vertical)
        cardView.autoPinEdge(toSuperviewEdge: .top, withInset: 30)
        
        cardView.backgroundColor = .blue
        cardView.layer.cornerRadius = 25
    }
    
    private func initIntputView(){
        view.addSubview(intputView)
        
        let heightCardView = UIScreen.main.bounds.width / 2
        
        intputView.autoPinEdge(toSuperviewEdge: .left)
        intputView.autoPinEdge(toSuperviewEdge: .bottom)
        intputView.autoPinEdge(toSuperviewEdge: .right)
        intputView.autoPinEdge(toSuperviewEdge: .top, withInset: 120)
        
        intputView.backgroundColor = .white
        intputView.layer.cornerRadius = 30
        
        intputView.addSubview(cardNumber)
        intputView.addSubview(expireView)
        intputView.addSubview(cvvView)
        intputView.addSubview(cardOwnerView)
        
        
        cardNumber.autoPinEdge(toSuperviewEdge: .top, withInset: heightCardView / 2)
        cardNumber.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        cardNumber.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        cardNumber.header.text = "Card number"
        cardNumber.editText.placeholder = "**** **** **** ****"
        cardNumber.editText.delegate = self
        expireView.autoPinEdge(.top, to: .bottom, of: cardNumber, withOffset: 16)
        expireView.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        let expWidrh = UIScreen.main.bounds.width/2 - 32 - 16
        expireView.autoSetDimension(.width, toSize: expWidrh)
        expireView.header.text = "Expire Date"
        expireView.editText.placeholder = "11/22"
        expireView.editText.delegate = self
        
        cvvView.autoPinEdge(.left, to: .right, of: expireView, withOffset: 32)
        cvvView.autoPinEdge(.top, to: .bottom, of: cardNumber, withOffset: 16)
        cvvView.autoPinEdge(toSuperviewEdge: .right,withInset: 32)
        cvvView.header.text = "CVV"
        cvvView.editText.delegate = self
        
        cardOwnerView.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        cardOwnerView.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        cardOwnerView.autoPinEdge(.top, to: .bottom, of: cvvView, withOffset: 16)
        cardOwnerView.header.text = "Card Owner"
        cardOwnerView.editText.delegate = self
    }
    
    private func initPriceView(){
        view.addSubview(priceView)
        
        priceView.autoPinEdge(toSuperviewEdge: .right)
        priceView.autoPinEdge(toSuperviewEdge: .bottom)
        priceView.autoPinEdge(toSuperviewEdge: .left)
        let window = UIApplication.shared.windows.first{$0.isKeyWindow}
        let height:CGFloat = 80 + (window?.safeAreaInsets.bottom ?? 0)
        priceView.autoSetDimension(.height, toSize: height)
        
        priceView.backgroundColor = .blue
        
        //Price
        priceView.addSubview(price)
        price.autoSetDimension(.width, toSize: UIScreen.main.bounds.width/3)
        price.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        price.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        price.textColor = .white
        price.font = UIFont.neuzeitBolt(size: 32)
        price.text = "100$"
        
        //Button
        let puyButton = UIButton()
        priceView.addSubview(puyButton)
        puyButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        puyButton.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        puyButton.autoPinEdge(.left, to: .right, of: price)
        puyButton.autoSetDimension(.height, toSize: 40)
        puyButton.backgroundColor = .white
        puyButton.layer.cornerRadius = 20
        
        puyButton.titleLabel?.font = UIFont.neuzeitReg(size: 20)
        puyButton.setTitleColor(.blue, for: .normal)
        puyButton.setTitle("Puy now", for: .normal)
        
        puyButton.addTarget(self, action: #selector(puyProvider), for: .touchUpInside)
    }
    
    @objc func puyProvider(button:UIButton){
        viewModel.checkCardData()
    }
    
    func showDatePicker(){
        
    }
    
    //MARK: View Model
    
    func updateCardType(){
        viewModel.updateCardType = {[weak self] type in
            self?.cardView.updateCardType(type: type)
        }
    }
    
    func checkCardData(){
        viewModel.incorrectCardData = { [weak self] value in
            switch value {
            case .number:
                self?.cardNumber.showWarning()
            case .expireDate:
                self?.expireView.showWarning()
            case .cvv:
                self?.cvvView.showWarning()
            case .cardOwner:
                self?.cardOwnerView.showWarning()
            default:
                self?.cardNumber.hideWarning()
                self?.expireView.hideWarning()
                self?.cvvView.hideWarning()
                self?.cardOwnerView.hideWarning()
                self?.router.openReceipt()
            }
        }
    }
}

extension PaymentViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var sourceText = textField.text else { return false}
        sourceText.append(string)
        
        if textField == cardNumber.editText{
            var result:String
            if range.length == 1 {
                result = sourceText.formatCardNumber(shouldRemoveLastDigit: true)
            } else {
                result = sourceText.formatCardNumber(shouldRemoveLastDigit: false)
            }
            
            viewModel.checkCardNumber(result)
            textField.text = result
            cardView.cardNumber.text = result
        } else if textField == cvvView.editText{
            self.viewModel.checkCvvNumber(textField.text ?? "")
            return sourceText.count <= 3
        } else if textField == expireView.editText {
            var result:String
            if range.length == 1 {
                result = sourceText.formatDate(shouldRemoveLastDigit: true)
            } else {
                result = sourceText.formatDate(shouldRemoveLastDigit: false)
            }
            expireView.editText.text = result
            cardView.expireDate.text = result
            self.viewModel.checkExpireDate(textField.text ?? "")
        }else if textField == cardOwnerView.editText{
            var result = sourceText
            if range.length == 1 {
                let end = sourceText.index(sourceText.startIndex, offsetBy: sourceText.count-1)
                result = String(sourceText[sourceText.startIndex..<end])
            }
            cardView.cardOwner.text = result
            self.viewModel.checkCardOwner(textField.text ?? "")
            return sourceText.count <= 22
        }
        return false
    }
}
