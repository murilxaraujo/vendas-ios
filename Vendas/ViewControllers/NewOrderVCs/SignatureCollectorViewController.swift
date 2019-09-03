//
//  OrderSummaryViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 19/08/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class SignatureCollectorViewController: UIViewController, SignatureDrawingViewControllerDelegate {
    
    //MARK: - Variables and functions
    
    var orderItem: NewOrder?
    
    //MARK: - View elements
    
    let signatureComponent: SignatureDrawingViewController = {
        let view = SignatureDrawingViewController()
        view.view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Class routine methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setDeviceToLandscapeMode(false)
    }
    
    //MARK: - Methods
    
    func setupView() {
        view.backgroundColor = .white
        signatureComponent.delegate = self
        self.navigationItem.title = "Colher assinatura"
        self.addChild(signatureComponent)
        self.view.addSubview(signatureComponent.view)
        signatureComponent.didMove(toParent: self)
        signatureComponent.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        signatureComponent.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        signatureComponent.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        signatureComponent.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        setDeviceToLandscapeMode(true)
        let netxButton = UIBarButtonItem(title: "Enviar", style: .plain, target: self, action: #selector(nextView(_:)))
        self.navigationItem.setRightBarButton(netxButton, animated: true)
    }
    
    func setDeviceToLandscapeMode(_ orientation: Bool) {
        var value: Any
        if orientation {
            value = UIInterfaceOrientation.landscapeRight.rawValue
        } else {
            value = UIInterfaceOrientation.portrait.rawValue
        }
        
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    @objc func nextView(_ sender: Any) {
        setDeviceToLandscapeMode(false)
        DataService.shared.sendSignatureToCloud(signatureComponent.fullSignatureImage!) { (urlString, error) in
            if error != nil {
                print(error!)
                return
            }
            self.orderItem?.signatureURL = urlString
            
            DataService.shared.sendOrderToProtheus(self.orderItem!, completionHandler: { (order, error) in
                if error != nil {
                    print(error!)
                    self.setDeviceToLandscapeMode(true)
                }
                
                RealmService.shared.save(order!)
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    //MARK: - Signature collection routine functions
    
    func signatureDrawingViewControllerIsEmptyDidChange(controller: SignatureDrawingViewController, isEmpty: Bool) {
     
    }

}
