//
//  ItemsSelectionViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar

class ItemsSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        self.navigationItem.title = "Itens"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar item"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        itemsFiltered = items.filter({( candy : Product) -> Bool in
            return candy.getCodeAndName().lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive || !searchBarIsEmpty()
    }
    
    // MARK: - TableView routine functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return itemsFiltered.count
        }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ItemSelectionTableViewCell
        let item: Product
        if isFiltering() {
            item = itemsFiltered[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        cell.titleLabel.text = item.getCodeAndName()
        cell.uMedidaLabel.text = "Medida: \(item.unidademedida)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item: Product
        if isFiltering() {
            item = itemsFiltered[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        
        let modalView = ProductSelectedViewController()
        modalView.modalPresentationStyle = .overFullScreen
        modalView.productID = item.codigo.trimmingCharacters(in: .whitespacesAndNewlines)
        modalView.clientID = self.formerViewController?.newOrderItem?.client?.codigo.trimmingCharacters(in: .whitespacesAndNewlines)
        modalView.clientLoja = self.formerViewController?.newOrderItem?.client?.loja.trimmingCharacters(in: .whitespacesAndNewlines)
        modalView.previousVC = self
        modalView.product = Product(codigo: item.codigo, nome: item.nome, unidadeDeMedida: item.unidademedida, saldo: "\(item.saldo)")
        DataService.shared.getProductSaldo(item) { (saldo, erro) in
            
            
            DispatchQueue.main.async {
                if erro != nil {
                    let message = MDCSnackbarMessage(text: "Erro ao buscar saldo dos produtos")
                    MDCSnackbarManager.show(message)
                    return
                }
                
                modalView.saldo = saldo!
                self.present(modalView, animated: true, completion: nil)
            }
        }
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
    
    func onProductSelected(_ product: ProdutoPedido) {
        self.formerViewController?.addItem(product)
        self.closeView(sender: self)
    }
    
    func getData() {
        items = DataService.shared.getProdutos()
        tableView.reloadData()
        print("Got data", items.count)
    }
    
    // MARK: - Callback method
}

extension ItemsSelectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
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
