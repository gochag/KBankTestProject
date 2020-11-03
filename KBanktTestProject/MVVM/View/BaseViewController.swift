//
//  BaseViewController.swift
//  KBanktTestProject
//
//  Created by Tarlan Hekimzade on 31.10.2020.
//  Copyright © 2020 Tarlan Hekimzade. All rights reserved.
//

import UIKit
import PureLayout

class BaseViewController:UIViewController{
    
    var icons = ["ic_cash","ic_exchange","ic_get_maney","ic_maneybox","ic_safe","ic_pay"]
    private var spinner = UIActivityIndicatorView(style: .large)

    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        
        let navigation = self.navigationController?.navigationBar
        navigation?.barTintColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        navigation?.tintColor = .white
        navigation?.titleTextAttributes = [.foregroundColor : UIColor.white,
                                           .font : UIFont.neuzeitBolt(size: 22)]
        navigation?.isTranslucent = false
        navigation?.setBackgroundImage(UIImage(), for:.default)
        navigation?.shadowImage = UIImage()
        navigation?.layoutIfNeeded()
    }
    
    func showLoading(){
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.autoCenterInSuperview()
    }
    
    func hideLoading(){
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}
