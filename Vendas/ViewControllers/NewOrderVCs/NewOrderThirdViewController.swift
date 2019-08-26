//
//  NewOrderThirdViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class NewOrderThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables and constants
    
    var previousVC: NewOrderSecondViewController?
    var newOrderItem: NewOrder?
    var products: [ProdutoPedido] = []
    
    // MARK: - View elements
    
    let addItemButton: MDCFloatingButton = {
        let button = MDCFloatingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdviewcell") as! ThirdOrderViewTableViewCell
        cell.titleLabel.text = "\(products[indexPath.item].quantidade!)\(products[indexPath.item].produto.unidademedida) \(products[indexPath.item].produto.nome)"
        return cell
    }
    
    // MARK: - Functions

    func setupViewElements() {
        self.navigationItem.title = "Itens"
        
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ThirdOrderViewTableViewCell.self, forCellReuseIdentifier: "thirdviewcell")
        
        self.view.addSubview(addItemButton)
        addItemButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addItemButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        addItemButton.addTarget(self, action: #selector(openItemSelectVC(_:)), for: .touchUpInside)
        let image: UIImage = UIImage(named: "round_add_black_36pt")!
        addItemButton.tintColor = .white
        addItemButton.setImage(image, for: .normal)
        
        
        let signatureColectionButton = UIBarButtonItem(title: "Próximo", style: .plain, target: self, action: #selector(nextView(_:)))
        self.navigationItem.setRightBarButton(signatureColectionButton, animated: true)
        
        openItemSelectVC(self)
    }
    
    @objc func openItemSelectVC(_ sender: Any) {
        let vc = ItemsSelectionViewController()
        vc.formerViewController = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    func addItem(_ item: ProdutoPedido) {
        products.append(item)
        tableView.reloadData()
    }
    
    @objc func nextView(_ sender: Any) {
        let vc = SignatureCollectorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class ThirdOrderViewTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
