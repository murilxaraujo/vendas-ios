//
//  NewOrderViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class NewOrderViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.text = "Selecione a filial"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let brButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Metalforte BR", for: .normal)
        
        return button
    }()
    
    let poloButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Metalforte Polo", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewElements()
    }
    
    func setupViewElements() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Novo pedido"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        
        self.view.addSubview(label)
        label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        label.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        self.view.addSubview(brButton)
        brButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        brButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        brButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        self.view.addSubview(poloButton)
        poloButton.topAnchor.constraint(equalTo: brButton.bottomAnchor, constant: 20).isActive = true
        poloButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        poloButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
