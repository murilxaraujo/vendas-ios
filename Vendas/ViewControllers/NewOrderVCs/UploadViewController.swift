//
//  UploadViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 04/09/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import Lottie
import FirebaseStorage
import MaterialComponents.MaterialSnackbar

class UploadViewController: UIViewController {

    // MARK: - Variables and constants
    
    var previousVC: SignatureCollectorViewController?
    var orderItem: NewOrder?
    var orderNumber: String? = nil
    var signatureImage: UIImage?
    // MARK: - View elements
    var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var successView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var loadingAnimation: AnimationView = {
        let lot = AnimationView()
        lot.translatesAutoresizingMaskIntoConstraints = false
        lot.loopMode = LottieLoopMode.loop
        return lot
    }()
    
    var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enviando dados"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        sendDataToCloud()
    }
        
    
    func setupInitialView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(loadingView)
        view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        loadingAnimation.animation = Animation.named("loader")
        // Do any additional setup after loading the view.
        self.loadingView.addSubview(loadingAnimation)
        loadingAnimation.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
        loadingAnimation.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        loadingAnimation.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        loadingAnimation.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.loadingView.addSubview(loadingLabel)
        loadingLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: loadingAnimation.bottomAnchor, constant: 40).isActive = true
        
        loadingAnimation.play()
    }
    
    func onUploadSuccess(orderCode: String?) {
        view.addSubview(successView)
        successView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        successView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        successView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        successView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        let successAnimation: AnimationView = {
            let av = AnimationView()
            av.translatesAutoresizingMaskIntoConstraints = false
            av.animation = Animation.named("success")
            av.loopMode = .playOnce
            return av
        }()
        
        successView.addSubview(successAnimation)
        successAnimation.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 100).isActive = true
        successAnimation.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        successAnimation.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let successLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = {
                if orderCode == nil {
                    return "error"
                } else {
                    return "Pedido realizado com sucesso sob o código \(orderCode!)"
                }
            }()
            return label
        }()
        
        successView.addSubview(successLabel)
        successLabel.topAnchor.constraint(equalTo: successAnimation.bottomAnchor, constant: 0).isActive = true
        successLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        successLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        successAnimation.play()
    }
    
    func sendDataToCloud() {
        DataService.shared.sendSignatureToCloud(signatureImage ?? UIImage()) { (urlString, error) in
            if error != nil {
                print(error!)
                let message = MDCSnackbarMessage(text: "Erro: \(error!)")
                MDCSnackbarManager.show(message)
                self.loadingAnimation.stop()
                return
            }
            self.orderItem?.signatureURL = urlString
            
            DataService.shared.sendOrderToProtheus(self.orderItem!, completion: { (order, error) in
                if error != nil {
                    print(error!)
                    self.loadingAnimation.stop()
                    let message = MDCSnackbarMessage(text: "Erro: \(error!)")
                    MDCSnackbarManager.show(message)
                    
                    return
                } else {
                    self.onUploadSuccess(orderCode: order)
                }
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

}
