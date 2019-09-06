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
        button.setTitle("Baixar tabelas", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundColor(UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0))
        button.layer.cornerRadius = 10
        let dataDownloadIcon = UIImage(named: "baseline_save_alt_black_24pt")?.withRenderingMode(.alwaysTemplate)
        button.setImage(dataDownloadIcon, for: .normal)
        button.setImageTintColor(.white, for: .normal)
        return button
    }()
    
    let syncDataButton: MDCFloatingButton = {
        let button = MDCFloatingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(named: "baseline_backup_black_24pt")?.withRenderingMode(.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.backgroundColor = .white
        button.setImageTintColor(UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0), for: .normal)
        return button
    }()
    
    // MARK: - Class routine functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
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
        downloadDataButton.addTarget(self, action: #selector(dataLocalBackup(sender:)), for: .touchUpInside)
        downloadDataButton.isEnabled = false
        
        self.topView.addSubview(syncDataButton)
        syncDataButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        syncDataButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        syncDataButton.isEnabled = false
        /*
        if !DataService.shared.hasDownloadedData() {
            DataService.shared.getTransportadorasDataFromCloudToLocal()
            DataService.shared.getCondsPagamentoFromCloudToLocal()
            DataService.shared.getRegraDeDescontoFromCloudToLocal()
            DataService.shared.saveClientsInitialFileToDB()
            DataService.shared.saveProductsInitialFileToDB()
            DataService.shared.getRealmPath()
            let  message = MDCSnackbarMessage(text: "Dados foram baixados com sucesso")
            MDCSnackbarManager.show(message)
            DataService.shared.setHasDownloadedData(true)
        }
 */
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
    
}
