//
//  ViewController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

class CategoryViewController: BaseViewController {
    
        //MARK: Veriable
    var router:RouterProtocol!
    var viewModel:CategoryViewModelProtocol!
    
    private var categorys = [CategoryData]()
    

    private var infoView = UIView()
    private var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        
        updateView()
        loadData()
    }
    
    //MARK: Init view
    private func initCollectionView(){
        let layout = CategoryLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.autoPinEdgesToSuperviewEdges()
        
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.ID)
        
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func initInfoView(_ savedCache:Bool){
        view.addSubview(infoView)
        
        infoView.autoSetDimension(.height, toSize: 300)
        infoView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        infoView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        infoView.autoCenterInSuperview()
        infoView.layer.cornerRadius = 15
        infoView.backgroundColor = .white
        
        let messageText = UILabel()
        let stackView = UIStackView()
        
        infoView.addSubview(messageText)
        infoView.addSubview(stackView)
        
        stackView.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        stackView.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        stackView.autoSetDimension(.height, toSize: 50)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        for item in 1 ... (savedCache ? 2 : 1) {
            let button = UIButton()
            button.backgroundColor = item == 1 ? UIColor.gray : UIColor.orange
            button.setTitle(item == 1 ? "Ok": "Load", for: .normal)
            button.tag = item
            button.layer.cornerRadius = 15
            button.titleLabel?.font = UIFont.neuzeitBolt()
            button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        messageText.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        messageText.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        messageText.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        messageText.autoPinEdge(.bottom, to: .top, of: stackView)
        
        messageText.text = savedCache ? "No internet connection, do you want to download cached data?" : "No internet connection. Please, check your connection"
        messageText.textAlignment = .center
        messageText.font = UIFont.neuzeitReg(size: 22)
        messageText.textColor = .black
        messageText.numberOfLines = 0
    }
    
    //MARK: ViewModel
    
    private func loadData(){
        viewModel.loadData()
    }
    
    private func updateView(){
        viewModel.updateCategories = { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .loading:
                    self?.showLoading()
                case .success(let categorys):
                    self?.categorys = categorys
                    self?.collectionView.reloadData()
                    self?.hideLoading()
                case .error(let error):
                    self?.hideLoading()
                    switch error {
                    case CategoryError.NoInternetCacheSaved:
                        self?.initInfoView(true)
                    case CategoryError.NoInternet:
                       self?.initInfoView(false)
                    default:
                        break
                    }
                }
            }
        }
    }
    
    @objc func clickButton(button:UIButton){
        if button.tag == 1 {
            
        } else {
            infoView.removeFromSuperview()
            viewModel.loadCacheData()
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.ID, for: indexPath) as! CategoryCell
        let img = UIImage(named: icons[indexPath.row % 6])
        cell.updateView(categorys[indexPath.row], image: img)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router.openProvider(category:categorys[indexPath.row])
    }
}
