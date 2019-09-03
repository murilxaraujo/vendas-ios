 //
//  SummaryTableViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 02/09/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class SummaryTableViewController: UITableViewController {

    // MARK: - Variables and constants
    
    private var sections: [TVSection] = []
    private var cellID = "VaaahlaMeuPai"
    var orderItem: NewOrder?
    var previousVC: NewOrderThirdViewController?
    
    // MARK: - ViewController class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
    }
    
    // MARK: - TableView Setup
    
    func tableViewSetup() {
        //tableView.register(nil, forCellReuseIdentifier: cellID)
        self.navigationItem.title = "Resumo do pedido"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].items[indexPath.row].height
    }
    
    private struct TVSection {
        var items: [RowItem] = []
        var title: String = ""
        
        init(title: String) {
            self.title = title
        }
    }

    private struct RowItem {
        var title: String
        var content: String
        var height: CGFloat
        
        init(title: String, content: String, height: CGFloat?) {
            self.title = title
            self.content = content
            self.height = height ?? 60
        }
    }
}
