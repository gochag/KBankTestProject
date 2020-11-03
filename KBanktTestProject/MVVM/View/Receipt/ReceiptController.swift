//
//  ReceiptViewController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

enum ReceiptItemType{
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
    var viewModel:ReceiptViewModelProtocol!
    
    let items:[ReceiptItemType] = [.date,.ownerCode,.bankCode,.discount,.tax,.price]

    var receiptView = UIView()
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
    
    let itemOne = ReceiptItem()
    let itemTwo = ReceiptItem()

    let itemThree = ReceiptItem()

    let itemFore = ReceiptItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        initReceiptView()
        initConfirmButton()
        updateViewData()
        getReceiptData()
    }
    
    //MARK: init view
    private func initReceiptView(){
        view.addSubview(receiptView)
        
        receiptView.backgroundColor = .white
        receiptView.autoSetDimension(.height, toSize: UIScreen.main.bounds.height/2)
        receiptView.autoPinEdge(toSuperviewEdge: .left, withInset: 48)
        receiptView.autoPinEdge(toSuperviewEdge: .right, withInset: 48)
        receiptView.autoPinEdge(toSuperviewEdge: .top)
        
        receiptView.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 70)
        stackView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func initConfirmButton(){
        view.addSubview(confirmButton)
        confirmButton.autoAlignAxis(toSuperviewAxis: .vertical)
        confirmButton.autoPinEdge(toSuperviewEdge: .left, withInset: 48)
        confirmButton.autoPinEdge(toSuperviewEdge: .right, withInset: 48)
        confirmButton.autoPinEdge(.top, to: .bottom, of: receiptView, withOffset: 32)
        confirmButton.autoSetDimension(.height, toSize: 50)
        
        confirmButton.setTitle("Ok", for: .normal)
        confirmButton.backgroundColor = .orange
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 25
        confirmButton.titleLabel?.font = UIFont.neuzeitBolt(size: 22)
        confirmButton.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    
    //MARK: View model
    
    private func getReceiptData(){
        viewModel.featchData()
    }
    
    private func updateViewData(){
        viewModel.updateView = {[weak self] data in
            self?.items.forEach { type in
                let receiptItme = ReceiptItem()
                self?.stackView.addArrangedSubview(receiptItme)
                
                switch type {
                case .date:
                    receiptItme.updateView(title: "Date:", value: data.date)
                case .bankCode:
                    receiptItme.updateView(title: "Service:", value: data.details.first?.value ?? "no data")
                case .ownerCode:
                    receiptItme.updateView(title: "Subscriber:", value: data.details.last?.value ?? " no data")
                case .discount:
                    receiptItme.updateView(title: "Discount:", value: "01.11.2020")
                case .tax:
                    receiptItme.updateView(title: "Tax:", value: "01.11.2020")
                case .price:
                    receiptItme.updateView(title: "Price:", value: data.amount.first?.value ?? "0")
                }
            }
        }
    }
    
    @objc func clickConfirm(){
        router.popToRoot()
    }
}

class ReceiptItem:UIView{
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
