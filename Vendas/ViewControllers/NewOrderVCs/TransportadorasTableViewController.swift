//
//  TransportadorasTableViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 27/08/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class TransportadorasTableViewController: UITableViewController {

    var items: [Transportadora] = []
    var filteredItems: [Transportadora] = []
    var previousVC: NewOrderSecondViewController? = nil
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemSelectionTableViewCell.self, forCellReuseIdentifier: "cellidd")
        self.navigationItem.title = "Transportadoras"
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        items = DataService.shared.getTransportadorasFromDB()
        filteredItems = items
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar transportadoras"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredItems.count
        }
        
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellidd", for: indexPath) as! ItemSelectionTableViewCell
        let item: Transportadora
        if isFiltering() {
            item = filteredItems[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        cell.titleLabel.text = item.nome
        cell.uMedidaLabel.text = item.codigo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var item: Transportadora
        if isFiltering() {
            item = filteredItems[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        previousVC?.onTransportadoraSelected(item)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - SearchController classes
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = items.filter({( item : Transportadora) -> Bool in
            return item.getCodigoAndNomeAsString().lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive || !searchBarIsEmpty()
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension TransportadorasTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
