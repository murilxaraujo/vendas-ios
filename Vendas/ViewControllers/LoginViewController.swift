//
//  LoginViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 05/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialButtons

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let logoBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0)
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        return label
    }()
    
    let userNameTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Usuário"
        return tf
    }()
    let usernameTextFieldController: MDCTextInputControllerFilled
    
    let senhaTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Senha"
        tf.isSecureTextEntry = true
        return tf
    }()
    let senhaTextFieldController: MDCTextInputControllerFilled
    
    let loginButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.setBackgroundColor(UIColor(red:0.25, green:0.32, blue:0.71, alpha:1.0))
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        usernameTextFieldController = MDCTextInputControllerFilled(textInput: userNameTextField)
        senhaTextFieldController = MDCTextInputControllerFilled(textInput: senhaTextField)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewInterface()
    }
    
    func setupViewInterface() {
        self.view.backgroundColor = .white
        
        
        self.view.addSubview(logoBackgroundView)
        logoBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        logoBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        logoBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        logoBackgroundView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        logoBackgroundView.addSubview(loginLabel)
        loginLabel.leftAnchor.constraint(equalTo: logoBackgroundView.leftAnchor, constant: 20).isActive = true
        loginLabel.bottomAnchor.constraint(equalTo: logoBackgroundView.bottomAnchor, constant: -20).isActive = true
        
        self.view.addSubview(userNameTextField)
        userNameTextField.topAnchor.constraint(equalTo: logoBackgroundView.bottomAnchor, constant: 20).isActive = true
        userNameTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        userNameTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        userNameTextField.delegate = self
        
        self.view.addSubview(senhaTextField)
        senhaTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 0).isActive = true
        senhaTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        senhaTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        senhaTextField.delegate = self
        
        self.view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: senhaTextField.bottomAnchor, constant: 0).isActive = true
        loginButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        loginButton.addTarget(self, action: #selector(authenticate(sender:)), for: .touchUpInside)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func authenticate(sender: Any) {
        
    }

}
