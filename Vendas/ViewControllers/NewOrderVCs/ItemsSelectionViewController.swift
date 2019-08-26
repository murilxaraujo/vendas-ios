//
//  ItemsSelectionViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class ItemsSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    
    // MARK: - Variables and constants
    
    var formerViewController: NewOrderThirdViewController?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var items: [Product] = []
    var itemsFiltered: [Product] = []
    
    let cellID = "itemtableviewcell"
    
    // MARK: - View elements
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    // MARK: - Class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupViewElements()
        getData()
    }
    
    // MARK: - Searchbar routine functions
    
    func setupSearchBar() {
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.title = "Itens"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        itemsFiltered = items.filter({( product : Product) -> Bool in
            return product.getCodeAndName().lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    // MARK: - TableView routine functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return itemsFiltered.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ItemSelectionTableViewCell
        
        if isFiltering() {
            cell.titleLabel.text = itemsFiltered[indexPath.item].getCodeAndName()
            cell.uMedidaLabel.text = "Medida: \(itemsFiltered[indexPath.item].unidademedida), saldo: \(itemsFiltered[indexPath.item].saldo)"
        } else {
            cell.titleLabel.text = items[indexPath.item].getCodeAndName()
            cell.uMedidaLabel.text = "Medida: \(items[indexPath.item].unidademedida), saldo: \(items[indexPath.item].saldo)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var textfieldd: UITextField?
        let alertView = UIAlertController(title: "Quantidade", message: nil, preferredStyle: .alert)
        alertView.addTextField { (uitextfield) in
            uitextfield.placeholder = "Quantidade"
            uitextfield.keyboardType = .numberPad
            textfieldd = uitextfield
        }
        
        let alertViewAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            let item: ProdutoPedido = {
                if self.isFiltering() {
                   return ProdutoPedido(quantidade: Float("\(textfieldd!.text!)")!, produto: self.itemsFiltered[indexPath.item])
                } else {
                   return ProdutoPedido(quantidade: Float("\(textfieldd!.text!)")!, produto: self.items[indexPath.item])
                }
            }()
            self.formerViewController?.addItem(item)
            self.closeView(sender: alertView)
        }
        
        let alertViewCancelAction = UIAlertAction(title: "cancelar", style: .cancel) { (action) in
            
        }
        //condpag_pv transportadores_pv vendedores_pv
        alertView.addAction(alertViewAction)
        alertView.addAction(alertViewCancelAction)
        
        present(alertView, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Methods
    
    func setupViewElements() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.tableFooterView = UIView()
        tableView.register(ItemSelectionTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getData() {
        items = DataService.shared.getProdutos()
        tableView.reloadData()
        print("Got data", items.count)
    }
    
    // MARK: - Callback method
}

class ItemSelectionTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        return label
    }()
    
    let uMedidaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(10)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        
        addSubview(uMedidaLabel)
        uMedidaLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        uMedidaLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
    }
}
