//
//  HomeViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class HomeViewController: UIViewController {
    
    // MARK: - View elements
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Metalforte"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        return label
    }()
    
    let newClientButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Novo Cliente", for: .normal)
        button.setBackgroundColor(UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0))
        button.layer.cornerRadius = 10
        let newClientIcon = UIImage(named: "round_person_add_black_24pt")?.withRenderingMode(.alwaysTemplate)
        button.setImage(newClientIcon, for: .normal)
        button.setImageTintColor(.white, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    let newOrderButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Novo pedido", for: .normal)
        button.setBackgroundColor(UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0))
        button.layer.cornerRadius = 10
        let newOrderIcon = UIImage(named: "round_how_to_vote_black_24pt")?.withRenderingMode(.alwaysTemplate)
        button.setImage(newOrderIcon, for: .normal)
        button.setImageTintColor(.white, for: .normal)
        return button
    }()
    
    let downloadDataButton: MDCButton = {
        let button = MDCButton()
        button.setTitle("Atualizar tabelas", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundColor(UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0))
        button.layer.cornerRadius = 10
        let dataDownloadIcon = UIImage(named: "baseline_refresh_black_24pt")?.withRenderingMode(.alwaysTemplate)
        button.setImage(dataDownloadIcon, for: .normal)
        button.setImageTintColor(.white, for: .normal)
        button.addTarget(self, action: #selector(updateTableButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Class routine functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
        DataService.shared.getRealmPath()
        if !DataService.shared.hasDownloadedData() {
            downloadInitialData()
            DataService.shared.setHasDownloadedData(true)
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods
    
    func setupViewElements() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20).isActive = true
        
        self.view.addSubview(newClientButton)
        newClientButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        newClientButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        newClientButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        newClientButton.addTarget(self, action: #selector(newClient(sender:)), for: .touchUpInside)
        
        self.view.addSubview(newOrderButton)
        newOrderButton.topAnchor.constraint(equalTo: newClientButton.bottomAnchor, constant: 20).isActive = true
        newOrderButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        newOrderButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        newOrderButton.addTarget(self, action: #selector(newOrder(sender:)), for: .touchUpInside)
        
        self.view.addSubview(downloadDataButton)
        downloadDataButton.topAnchor.constraint(equalTo: newOrderButton.bottomAnchor, constant: 20).isActive = true
        downloadDataButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        downloadDataButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        downloadDataButton.addTarget(self, action: #selector(updateTableButtonPressed(_:)), for: .touchUpInside)
        downloadDataButton.isEnabled = true
        
    }
    
    @objc func newOrder(sender: Any) {
        let vc = UINavigationController(rootViewController: NewOrderViewController())
        self.show(vc, sender: nil)
    }
    
    @objc func newClient(sender: Any) {
        let vc = UINavigationController(rootViewController: NewClientViewController())
        self.present(vc, animated: true, completion: nil)
    }

    @objc func dataLocalBackup(sender: Any) {
        self.show(BackupDataDownloadViewController(), sender: nil)
    }
    
    @objc func updateTableButtonPressed(_ sender: Any) {
        let  message = MDCSnackbarMessage(text: "Atualizando tabelas...")
        MDCSnackbarManager.show(message)
        
        DataService.shared.updateTables()
    }
    
    func downloadInitialData() {
        
        // Regra de desconto Download
        do {
            let success = try DataService.shared.getRegraDeDescontoFromCloudToLocal()
            
            if success != true {
                let  message = MDCSnackbarMessage(text: "Erro ao baixar Regras de desconto")
                MDCSnackbarManager.show(message)
            }
        } catch {
            let  message = MDCSnackbarMessage(text: "Erro ao baixar Regras de desconto")
            MDCSnackbarManager.show(message)
        }
        
        // Transportadoras download
        
        do {
            try DataService.shared.getTransportadorasDataFromCloudToLocal()
        } catch {
            let  message = MDCSnackbarMessage(text: "Erro ao baixar transportadoras")
            MDCSnackbarManager.show(message)
        }
        
        // Cond. Pag download
        
        do {
            try DataService.shared.getCondsPagamentoFromCloudToLocal()
        } catch {
            let  message = MDCSnackbarMessage(text: "Erro ao baixar Cond. Pagamento")
            MDCSnackbarManager.show(message)
        }
        
        // Products saving
        
        do {
            try DataService.shared.saveProductsInitialFileToDB()
        } catch {
            let  message = MDCSnackbarMessage(text: "Erro ao salvar produtos")
            MDCSnackbarManager.show(message)
        }
        
        // Clients saving
        
        do {
            try DataService.shared.saveClientsInitialFileToDB()
        } catch {
            let  message = MDCSnackbarMessage(text: "Erro ao salvar clientes")
            MDCSnackbarManager.show(message)
        }
        
        let  message = MDCSnackbarMessage(text: "Dados foram baixados com sucesso")
        MDCSnackbarManager.show(message)
        DataService.shared.setHasDownloadedData(true)
    }
    
}
