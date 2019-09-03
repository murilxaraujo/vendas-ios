//
//  ClientSelectionViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class ClientSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celli") as! ItemSelectionTableViewCell
        cell.titleLabel.text = items[indexPath.item].Nome
        cell.uMedidaLabel.text = items[indexPath.item].codigo
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendClientBackToPreviousVC(items[indexPath.item])
    }
    
    // MARK: - Search controller routine functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
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
        mainViewController?.onClientSelected(client)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
