//
//  ProviderViewController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

class ProviderViewController: BaseViewController{
    
    //MARK: Variable
    var router:Router!
    var viewModel:ProviderViewModelProtocol!
    
    var list = [ProviderData]()
    
    let topLabel = UILabel()
    let providerView = UIView()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initTopLabel()
        
        updateView()
        loadData()
    }
    
    //MARK: init view

    private func initTableView(){
        view.addSubview(providerView)
        providerView.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        providerView.autoPinEdge(toSuperviewEdge: .right)
        providerView.autoPinEdge(toSuperviewEdge: .bottom)
        providerView.autoPinEdge(toSuperviewEdge: .left)
        
        providerView.addSubview(tableView)
        tableView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        tableView.autoPinEdge(toSuperviewEdge: .right)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .left)
        tableView.register(ProviderCell.self, forCellReuseIdentifier: ProviderCell.ID)
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initTopLabel(){
        view.addSubview(topLabel)
        
        topLabel.autoPinEdge(toSuperviewSafeArea: .top)
        topLabel.autoPinEdge(toSuperviewEdge: .right)
        topLabel.autoPinEdge(toSuperviewEdge: .left)
        topLabel.autoPinEdge(.bottom, to: .top, of: providerView)
        
        topLabel.text = " Test"
        topLabel.textAlignment = .center
        topLabel.font = UIFont.neuzeitBolt(size: 40)
        topLabel.textColor = .white

    }
    
    //MARK: view model
    
    func loadData(){
        viewModel.featchData()
    }
    
    func updateView(){
        viewModel.updateView = { [weak self] data in
            switch data {
            case .success(let category):
                DispatchQueue.main.async {
                    self?.topLabel.text = category.name
                    self?.list = category.providers
                    self?.tableView.reloadData()
                }
            default:
                break
            }
        }
    }
}

extension ProviderViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProviderCell.ID, for: indexPath) as! ProviderCell
        let img = UIImage(named: icons[indexPath.row % 6])
        cell.updateCell(list[indexPath.row], image: img)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.openCheckout(list[indexPath.row])
    }
}
