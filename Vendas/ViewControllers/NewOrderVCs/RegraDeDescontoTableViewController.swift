//
//  RegraDeDescontoTableViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 02/09/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class RegraDeDescontoTableViewController: UITableViewController {

    var items: [RegraDeDesconto] = []
    var previousVC: NewOrderSecondViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Regras de desconto"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        tableView.register(ItemSelectionTableViewCell.self, forCellReuseIdentifier: "celli")
        items = DataService.shared.getRegrasDeDesconto()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celli", for: indexPath) as! ItemSelectionTableViewCell

        cell.titleLabel.text = items[indexPath.item].descricao
        cell.uMedidaLabel.text = items[indexPath.item].codigo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        previousVC?.onRegrasDeDescontoSelected(items[indexPath.item])
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
