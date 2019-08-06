//
//  NewOrderThirdViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class NewOrderThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables and constants
    
    var previousVC: NewOrderSecondViewController?
    var newOrderItem: NewOrder?
    
    // MARK: - View elements
    
    let addItemButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar item", for: .normal)
        return button
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }
    
    // MARK: - TableView routine functions
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - Functions

    func setupViewElements() {
        self.navigationItem.title = "Itens"
        
        self.view.addSubview(addItemButton)
        addItemButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        addItemButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        addItemButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        addItemButton.addTarget(self, action: #selector(openItemSelectVC(_:)), for: .touchUpInside)
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: addItemButton.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func openItemSelectVC(_ sender: Any) {
        let vc = ItemsSelectionViewController()
        vc.formerViewController = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    func addItem(_ item: Any) {
        
    }
}
