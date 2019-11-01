//
//  AttachedClientSelection.swift
//  Vendas
//
//  Created by Murilo Araujo on 01/11/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class AttachedClientSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    // MARK: - Variables and constants
    
    var mainViewController: NewOrderSecondViewController?
    var items: [Client] = []
    var filteredItems: [Client] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View elements
    
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    // MARK: - Class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupViewElements()
    }
    
    // MARK: - Table view routine functions
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = items.filter({( candy : Client) -> Bool in
            return candy.Nome.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive || !searchBarIsEmpty()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredItems.count
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celli") as! ItemSelectionTableViewCell
        if isFiltering() {
            cell.titleLabel.text = filteredItems[indexPath.item].Nome
            cell.uMedidaLabel.text = filteredItems[indexPath.item].codigo
        } else {
            cell.titleLabel.text = items[indexPath.item].Nome
            cell.uMedidaLabel.text = items[indexPath.item].codigo
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            sendClientBackToPreviousVC(filteredItems[indexPath.item])
        } else {
            sendClientBackToPreviousVC(items[indexPath.item])
        }
        
    }
    
    // MARK: - Search controller routine functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    // MARK: - Functions
    
    func setupViewElements() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemSelectionTableViewCell.self, forCellReuseIdentifier: "celli")
        items = DataService.shared.getClients()
        tableView.reloadData()
    }
    
    func setupSearchBar() {
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        self.navigationItem.title = "Clientes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Callback function
    
    func sendClientBackToPreviousVC(_ client: Client) {
        mainViewController?.onAttachedClientSelected(client)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

