//
//  VoucherViewController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

enum VoucherItemType{
    case date
    case ownerCode
    case bankCode
    case discount
    case tax
    case price
}

class ReceiptController: BaseViewController{
    
    //MARK: Variables
    var router:Router!
    var viewModel:VoucherViewModelProtocol!
    
    let items:[VoucherItemType] = [.date,.ownerCode,.bankCode,.discount,.tax,.price]

    var voucherView = UIView()
    var confirmButton = UIButton()

    let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Gochag Inc."
        label.font = UIFont.neuzeitBolt(size: 18)
        label.textAlignment = .center
        return label
    }()
    
    let itemOne = VoucherItem()
    let itemTwo = VoucherItem()

    let itemThree = VoucherItem()

    let itemFore = VoucherItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVoucherView()
        initConfirmButton()
    }
    
    //Mark: init view
    private func initVoucherView(){
        view.addSubview(voucherView)
        
        voucherView.backgroundColor = .white
        voucherView.autoSetDimension(.height, toSize: UIScreen.main.bounds.height/2)
        voucherView.autoPinEdge(toSuperviewEdge: .left, withInset: 48)
        voucherView.autoPinEdge(toSuperviewEdge: .right, withInset: 48)
        voucherView.autoPinEdge(toSuperviewEdge: .top)
        
        voucherView.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 70)
        stackView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        stackView.addArrangedSubview(titleLabel)
        items.forEach { type in
            let voucherItme = VoucherItem()
            stackView.addArrangedSubview(voucherItme)
            
            switch type {
            case .date:
                voucherItme.updateView(title: "Date:", value: "01.11.2020")
            case .bankCode:
                voucherItme.updateView(title: "Bank:", value: "01.11.2020")
            case .ownerCode:
                voucherItme.updateView(title: "Owner:", value: "01.11.2020")
            case .discount:
                voucherItme.updateView(title: "Discount:", value: "01.11.2020")
            case .tax:
                voucherItme.updateView(title: "Tax:", value: "01.11.2020")
            case .price:
                voucherItme.updateView(title: "Price:", value: "01.11.2020")
            }
        }
    }
    
    private func initConfirmButton(){
        view.addSubview(confirmButton)
        confirmButton.autoAlignAxis(toSuperviewAxis: .vertical)
        confirmButton.autoPinEdge(toSuperviewEdge: .left, withInset: 48)
        confirmButton.autoPinEdge(toSuperviewEdge: .right, withInset: 48)
        confirmButton.autoPinEdge(.top, to: .bottom, of: voucherView, withOffset: 32)
        confirmButton.autoSetDimension(.height, toSize: 50)
        
        confirmButton.setTitle("Ok", for: .normal)
        confirmButton.backgroundColor = .orange
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 25
        confirmButton.titleLabel?.font = UIFont.neuzeitBolt(size: 22)
        confirmButton.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    
    @objc func clickConfirm(){
        router.popToRoot()
    }
}

class VoucherItem:UIView{
    private var stackView = UIStackView()
    
    var title:UILabel = {
        let label = UILabel()
        label.text = "Key"
        label.font = UIFont.neuzeitReg(size: 20)
        label.textAlignment = .left
        return label
    }()
    
    var value:UILabel = {
        let label = UILabel()
        label.text = "Value"
        label.font = UIFont.neuzeitLight(size: 20)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(value)
    }
    
    func updateView(title t:String, value v:String){
        self.title.text = t
        self.value.text = v
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
