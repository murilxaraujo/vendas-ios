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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
