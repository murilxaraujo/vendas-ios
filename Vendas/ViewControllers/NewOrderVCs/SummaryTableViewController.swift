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
        setupClientData()
        setupInfoData()
        setupTransportadoraData()
        setupItensData()
        setupFinance()
        tableView.reloadData()
    }
    
    // MARK: - TableView Setup
    
    func tableViewSetup() {
        tableView.register(ItemSelectionTableViewCell.self, forCellReuseIdentifier: cellID)
        self.navigationItem.title = "Resumo do pedido"
        tableView.allowsSelection = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let netxButton = UIBarButtonItem(title: "Próximo", style: .plain, target: self, action: #selector(nextView(_:)))
        self.navigationItem.setRightBarButton(netxButton, animated: true)
    }
    
    // MARK: - Data setup methods
    
    func setupClientData() {
        var clientSection = TVSection(title: "Cliente")
        var rowItems = [RowItem]()
        rowItems.append(RowItem(title: "Código", content: orderItem!.client?.codigo ?? "Cliente não selecionado", height: 60))
        rowItems.append(RowItem(title: "Nome", content: orderItem!.client?.Nome ?? "Cliente não selecionado", height: 60))
        rowItems.append(RowItem(title: "Loja", content: orderItem!.client?.loja ?? "Cliente não selecionado", height: 60))
        
        clientSection.items = rowItems
        sections.append(clientSection)
    }
    
    func setupInfoData() {
        var infoSection = TVSection(title: "Detalhes")
        var rowItems = [RowItem]()
        rowItems.append(RowItem(title: "Kit", content: orderItem!.kit, height: 60))
        rowItems.append(RowItem(title: "Express", content: orderItem!.express, height: 60))
        
        infoSection.items = rowItems
        sections.append(infoSection)
    }
    
    func setupTransportadoraData() {
        var transportadoraData = TVSection(title: "Transporte")
        var rowItems = [RowItem]()
        rowItems.append(RowItem(title: "Transportadora", content: orderItem!.transportadora, height: 60))
        rowItems.append(RowItem(title: "Tipo", content: orderItem!.tipoDeFrete, height: 60))
        
        transportadoraData.items = rowItems
        sections.append(transportadoraData)
    }
    
    func setupItensData() {
        var itensSection = TVSection(title: "Itens")
        var rowItems = [RowItem]()
        for item in orderItem!.items {
            rowItems.append(RowItem(title: item.produto!.nome, content: "R$\(item.price)x\(item.quantidade)\(item.produto!.primeiraunidade.lowercased())", height: 60))
        }
        
        itensSection.items = rowItems
        sections.append(itensSection)
    }
    
    func setupFinance() {
        var financeSection = TVSection(title: "Orçamento")
        var rowItems = [RowItem]()
        var finalprice: Double = 0
        for item in orderItem!.items {
            finalprice = finalprice + Double(item.price)!;
        }
        rowItems.append(RowItem(title: "Valor final", content: "R$\(finalprice)", height: 60))
        financeSection.items = rowItems
        sections.append(financeSection)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ItemSelectionTableViewCell
        cell.titleLabel.text = sections[indexPath.section].items[indexPath.item].title
        cell.uMedidaLabel.text = sections[indexPath.section].items[indexPath.item].content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].items[indexPath.row].height
    }
    
    @objc func nextView(_ sender: UIBarButtonItem) {
        let vc = SignatureCollectorViewController()
        vc.orderItem = orderItem
        self.navigationController?.pushViewController(vc, animated: true)
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
