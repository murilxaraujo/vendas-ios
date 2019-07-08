//
//  NewOrderSecondViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class NewOrderSecondViewController: UIViewController {

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clienteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selecione um cliente"
        return label
    }()
    
    let clientSearchButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }
    
    func setupViewElements() {
        self.view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        scrollView.addSubview(clienteLabel)
        scrollView.addSubview(clientSearchButton)
        clientSearchButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        clientSearchButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        clienteLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        clienteLabel.centerYAnchor.constraint(equalTo: clientSearchButton.centerYAnchor).isActive = true
        clienteLabel.rightAnchor.constraint(equalTo: clientSearchButton.leftAnchor, constant: -20).isActive = true
        
        
    }
    
}
