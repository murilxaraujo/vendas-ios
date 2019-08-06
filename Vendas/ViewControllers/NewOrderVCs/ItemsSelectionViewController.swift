//
//  ItemsSelectionViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class ItemsSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    
    // MARK: - Variables and constants
    
    var formerViewController: NewOrderThirdViewController?
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
    }
    
    // MARK: - Searchbar routine functions
    
    func setupSearchBar() {
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        self.navigationItem.title = "Itens"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
    }
    
    // MARK: - TableView routine functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - Methods
    
    func setupViewElements() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Callback method
    
    func sendItemBack() {
        formerViewController!.addItem() {
            
        }
    }
}
