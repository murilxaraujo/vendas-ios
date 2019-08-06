//
//  NewClientViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTextInput
import MaterialComponents.MDCNavigationBar
import MaterialComponents.MaterialButtons

class NewClientViewController: UIViewController {
    // MARK: - Variables and constants
    
    
    // MARK: - View elements
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    let companyNameInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Nome"
        input.autocapitalizationType = .allCharacters
        input.autocorrectionType = .no
        return input
    }()
    
    let fantasyNameInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Nome fantasia"
        input.autocapitalizationType = .allCharacters
        return input
    }()
    
    let companyTypeInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Tipo"
        return input
    }()
    
    let companyCPFCNPJInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "CPF/CNPJ"
        input.keyboardType = .numberPad
        input.autocorrectionType = .no
        input.autocapitalizationType = .none
        return input
    }()
    
    let companyNatureTypeInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Tipo"
        return input
    }()
    
    let stateEnrollmentInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Inscrição estadual"
        return input
    }()
    
    let companyCEPInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "CEP"
        input.keyboardType = UIKeyboardType.numberPad
        return input
    }()
    
    let companyAddressInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Endereço"
        return input
    }()
    
    let companyStateInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Estado"
        return input
    }()
    
    let companyCityInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Cidade"
        return input
    }()
    
    let companyPhoneInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Telefone"
        input.keyboardType = UIKeyboardType.phonePad
        return input
    }()
    
    let saveButton: MDCButton = {
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar", for: .normal)
        return button
    }()
    
    let nomeTextFieldController: MDCTextInputControllerOutlined
    let nomeFantasiaTextFieldController: MDCTextInputControllerOutlined
    let cpfcnpjTextFieldController: MDCTextInputControllerOutlined
    let natureTypeTextFieldController: MDCTextInputControllerOutlined
    let stateEnrollmentTextFieldController: MDCTextInputControllerOutlined
    let companyCEPTextFieldController: MDCTextInputControllerOutlined
    let companyStateTextFieldController: MDCTextInputControllerOutlined
    let companyAddressTextFieldController: MDCTextInputControllerOutlined
    let companyCityTextFieldController: MDCTextInputControllerOutlined
    let companyPhoneTextFieldController: MDCTextInputControllerOutlined
    
    // MARK: - Class routine funcions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        nomeTextFieldController = MDCTextInputControllerOutlined(textInput: companyNameInput)
        nomeFantasiaTextFieldController = MDCTextInputControllerOutlined(textInput: fantasyNameInput)
        cpfcnpjTextFieldController = MDCTextInputControllerOutlined(textInput: companyCPFCNPJInput)
        natureTypeTextFieldController = MDCTextInputControllerOutlined(textInput: companyNatureTypeInput)
        stateEnrollmentTextFieldController = MDCTextInputControllerOutlined(textInput: stateEnrollmentInput)
        companyAddressTextFieldController = MDCTextInputControllerOutlined(textInput: companyAddressInput)
        companyStateTextFieldController = MDCTextInputControllerOutlined(textInput: companyStateInput)
        companyCityTextFieldController = MDCTextInputControllerOutlined(textInput: companyCityInput)
        companyPhoneTextFieldController = MDCTextInputControllerOutlined(textInput: companyPhoneInput)
        companyCEPTextFieldController = MDCTextInputControllerOutlined(textInput: companyCEPInput)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    func setupViewElements() {
        self.navigationItem.title = "Cadastrar cliente"

        let backbutton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeView(sender:)))
        self.navigationItem.setLeftBarButton(backbutton, animated: true)
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 950)
        
        scrollView.addSubview(companyNameInput)
        companyNameInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyNameInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        companyNameInput.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(fantasyNameInput)
        fantasyNameInput.topAnchor.constraint(equalTo: companyNameInput.bottomAnchor).isActive = true
        fantasyNameInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        fantasyNameInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyCPFCNPJInput)
        companyCPFCNPJInput.topAnchor.constraint(equalTo: fantasyNameInput.bottomAnchor).isActive = true
        companyCPFCNPJInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyCPFCNPJInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyNatureTypeInput)
        companyNatureTypeInput.topAnchor.constraint(equalTo: companyCPFCNPJInput.bottomAnchor).isActive = true
        companyNatureTypeInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyNatureTypeInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(stateEnrollmentInput)
        stateEnrollmentInput.topAnchor.constraint(equalTo: companyNatureTypeInput.bottomAnchor).isActive = true
        stateEnrollmentInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        stateEnrollmentInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyCEPInput)
        companyCEPInput.topAnchor.constraint(equalTo: stateEnrollmentInput.bottomAnchor).isActive = true
        companyCEPInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyCEPInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyAddressInput)
        companyAddressInput.topAnchor.constraint(equalTo: companyCEPInput.bottomAnchor).isActive = true
        companyAddressInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyAddressInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyStateInput)
        companyStateInput.topAnchor.constraint(equalTo: companyAddressInput.bottomAnchor).isActive = true
        companyStateInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyStateInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyCityInput)
        companyCityInput.topAnchor.constraint(equalTo: companyStateInput.bottomAnchor).isActive = true
        companyCityInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyCityInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(companyPhoneInput)
        companyPhoneInput.topAnchor.constraint(equalTo: companyCityInput.bottomAnchor).isActive = true
        companyPhoneInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        companyPhoneInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: companyPhoneInput.bottomAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
    }
    
    @objc func closeView(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveInfo() {
        //DataService.shared.saveNewClient(client: <#T##NewClient#>)
    }
}
