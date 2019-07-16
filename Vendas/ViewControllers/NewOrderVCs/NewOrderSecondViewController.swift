//
//  NewOrderSecondViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTextFields

class NewOrderSecondViewController: UIViewController {
    
    //MARK: - Variables and constants

    var newOrderItem: NewOrder?
    
    // MARK: - View elements
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let clienteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Selecione um cliente"
        return label
    }()
    
    let clientSearchButton: MDCFlatButton = {
        let button = MDCFlatButton()
        button.setImage(UIImage(named: "round_search_black_36pt"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let clientTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Cliente"
        return input
    }()
    
    let clientTextInputController: MDCTextInputControllerOutlined!
    
    // MARK: - Class routine functions
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        clientTextInputController = MDCTextInputControllerOutlined(textInput: clientTextInput)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }
    
    // MARK: - Functions
    
    func setupViewElements() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Informações"
        
        self.view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        scrollView.backgroundColor = .white

        let textFieldButton = UIButton(type: .custom)
        textFieldButton.setImage(UIImage(named: "round_search_black_24pt"), for: .normal)
        textFieldButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28);
        textFieldButton.addTarget(self, action: #selector(openClientSelection(_:)), for: .touchUpInside)
        scrollView.addSubview(clientTextInput)
        clientTextInput.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        clientTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        clientTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        clientTextInput.rightView = textFieldButton
        clientTextInput.rightViewMode = .always
    }
    
    func onClientSelected(_ client: Client) {
        newOrderItem?.client = client
        clientTextInput.text = client.name
        fillInfoWithClientDetais(client)
    }
    
    @objc fileprivate func openClientSelection(_ sender: Any) {
        let vc = ClientSelectionViewController()
        vc.mainViewController = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    fileprivate func fillInfoWithClientDetais(_ client: Client) {
        
    }
    
}
