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
    
    //MARK: - Signature collection routine functions
    
    func signatureDrawingViewControllerIsEmptyDidChange(controller: SignatureDrawingViewController, isEmpty: Bool) {
     
    }

    
    
}
