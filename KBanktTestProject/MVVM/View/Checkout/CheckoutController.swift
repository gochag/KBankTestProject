//
//  CheckoutController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 03.11.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

class CheckoutController:BaseViewController{
    //MARK: Variable
    var router:Router!
    var viewModel:CheckoutViewModelProtocol!
    
    private let topLabel = UILabel()
    private var checkoutView = UIView()
    private var confirmButton = UIButton()
    
    private let provider = UILabel()
    private let info = UILabel()
    private let number = TextFieldWithHeader()
    private let amount = TextFieldWithHeader()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfirmButton()
        initCheckoutView()
        initTopLabel()
        
        updatedFields()
        updatedView()
        fetchData()
    }
    
    //MARK: init view
    private func initConfirmButton(){
        view.addSubview(confirmButton)
        confirmButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        confirmButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        confirmButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32)
        confirmButton.autoSetDimension(.height, toSize: 55)

        confirmButton.setTitle("Next", for: .normal)
        confirmButton.titleLabel?.font = UIFont.neuzeitBolt(size: 20)
        confirmButton.backgroundColor = .orange
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.layer.cornerRadius = 20
        confirmButton.addTarget(self, action: #selector(clickConfirmButton), for: .touchUpInside)
    }
    
    private func initCheckoutView(){
        view.addSubview(checkoutView)
        checkoutView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        checkoutView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        checkoutView.autoPinEdge(.bottom, to: .top, of: confirmButton, withOffset: -16)
        checkoutView.autoSetDimension(.height, toSize: UIScreen.main.bounds.height / 2)
        checkoutView.backgroundColor = .white
        checkoutView.layer.cornerRadius = 15
        
        checkoutView.addSubview(provider)
        checkoutView.addSubview(info)
        checkoutView.addSubview(number)
        checkoutView.addSubview(amount)
        

        provider.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        provider.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        provider.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        provider.text = "Azercell"
        provider.textColor = .black
        provider.font = UIFont.neuzeitBolt(size: 20)
        
        info.autoPinEdge(.top, to: .bottom, of: provider, withOffset: 8)
        info.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        info.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        info.text = "Azercell"
        info.textColor = .black
        info.font = UIFont.neuzeitLight()
        
        number.autoPinEdge(.top, to: .bottom, of: info, withOffset: 16)
        number.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        number.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        number.header.text = "Phone number"
        
        amount.autoPinEdge(.top, to: .bottom, of: number, withOffset: 16)
        amount.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        amount.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        amount.header.text = "Amount"
    }
    
    private func initTopLabel(){
        view.addSubview(topLabel)
        
        topLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        topLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        topLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        topLabel.autoPinEdge(.bottom, to: .top, of: checkoutView, withOffset: -16)

        topLabel.text = "Enter your  phone number"
        topLabel.font = UIFont.neuzeitBolt(size: 40)
        topLabel.textColor = .white
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
    }
    
    //MARK: ViewModel
    
    private func fetchData(){
        viewModel.fetchData()
    }
    
    private func updatedFields(){
        viewModel.updatedFields = {[weak self] field in
            switch field {
            case .number:
                self?.number.showWarning()
            case .amount:
                self?.amount.showWarning()
            default:
                self?.router.openPayment()
            }
        }
    }
    
    private func updatedView(){
        viewModel.updateView = {[weak self]  provider in
            self?.provider.text = provider.name
            self?.info.text = provider.name
        }
    }
    
    @objc func clickConfirmButton(){
        let num = number.editText.text
        let amount = number.editText.text
        viewModel.checkRequireFields(num,amount)
    }
}
