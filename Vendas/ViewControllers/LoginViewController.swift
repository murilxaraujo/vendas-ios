//
//  LoginViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 05/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let logoBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setupViewInterface() {
        self.view.addSubview(logoBackgroundView)
        logoBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        logoBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        logoBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        logoBackgroundView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        logoBackgroundView.addSubview(loginLabel)
        loginLabel.leftAnchor.constraint(equalTo: logoBackgroundView.leftAnchor, constant: 20).isActive = true
        loginLabel.bottomAnchor.constraint(equalTo: logoBackgroundView.bottomAnchor, constant: -20).isActive = true
    }

}
