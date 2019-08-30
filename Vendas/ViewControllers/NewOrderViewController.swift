//
//  NewOrderViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class NewOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: -Variables and constants
    let cellid = "itemCell"
    let newOrderItem = NewOrder()
    let menuOptions = ["Metalforte Polo", "MetalforteBR"]
    //MARK: -View elements
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //MARK: -Class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewElements()
    }
    
    //MARK: -TableView routine functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! newOrderFirstPageTableViewCell
        cell.title = menuOptions[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.item {
        case 0:
            poloSelected(tableView)
        case 1:
            brSelected(tableView)
        default:
            print("error")
        }
    }
    
    //MARK: -Functions
    
    func setupViewElements() {
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Novo pedido"
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(newOrderFirstPageTableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.tableFooterView = UIView()
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func poloSelected(_ sender: Any) {
        let vc = NewOrderSecondViewController()
        newOrderItem.filial = "02"
        vc.newOrderItem = newOrderItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func brSelected(_ sender: Any) {
        let vc = NewOrderSecondViewController()
        newOrderItem.filial = "01"
        vc.newOrderItem = newOrderItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class newOrderFirstPageTableViewCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var title : String! {
        didSet {
            label.text = title
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(label)
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
