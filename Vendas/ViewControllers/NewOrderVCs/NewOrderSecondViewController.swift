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
    
    let lojaTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Loja"
        return input
    }()
    
    let clienteDeEntregaTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Cliente de entrega"
        return input
    }()
    
    let clientNameTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Nome do cliente"
        return input
    }()
    
    let pvVinculadoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "PV vinculado"
        return input
    }()
    
    let avalistaTextInput: MDCTextField = {
        let input = MDCTextField()
        input.placeholder = "Avalista"
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    let lojaAvalistaTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Loja Avalista"
        return input
    }()
    
    let kitTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Kit"
        return input
    }()
    
    let tipoDeClienteTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Tipo de cliente"
        return input
    }()
    
    let expressTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Express"
        return input
    }()
    
    let unidadeDeMedidaTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Unidade de medida"
        return input
    }()
    
    let tipodeFreteTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Tipo de frete"
        return input
    }()
    
    let transportadoraTextInput: MDCTextField = {
        let input = MDCTextField()
        return input
    }()
    
    let condicaoDePagamentoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Condições de pagamento"
        return input
    }()
    
    let descDasCondicoesDePagamentoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Descrição das condições de pagamento"
        return input
    }()
    
    let regraDeDescontoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Regra de desconto"
        return input
    }()
    
    let descontoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Desconto"
        return input
    }()
    
    let contratoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Contrato"
        return input
    }()
    
    let observacaoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Observação"
        return input
    }()
    
    let pesoLiquidoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Peso líquido"
        return input
    }()
    
    let pesoBrutoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Peso bruto"
        return input
    }()
    
    let cepTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "CEP"
        return input
    }()
    
    let clientTextInputController: MDCTextInputControllerOutlined!
    let lojaTextInputController: MDCTextInputControllerOutlined!
    let clienteDeEntregaTextInputController: MDCTextInputControllerOutlined!
    let clientNameTextInputController: MDCTextInputControllerOutlined!
    let pvVinculadoTextInputController: MDCTextInputControllerOutlined!
    let avalistaTextInputController: MDCTextInputControllerOutlined!
    let lojaAvalistaTextInputController: MDCTextInputControllerOutlined!
    let kitTextInputController: MDCTextInputControllerOutlined!
    let tipoDeClienteTextInputController: MDCTextInputControllerOutlined!
    let expressTextInputController: MDCTextInputControllerOutlined!
    let unidadeDeMedidaTextInputController: MDCTextInputControllerOutlined!
    let tipoDeFreteTextInputController: MDCTextInputControllerOutlined!
    let transportadoraTextInputController: MDCTextInputControllerOutlined!
    let condicaoDePagamentoTextInputController: MDCTextInputControllerOutlined!
    let descDasCondicoesDePagamentoTextInputController: MDCTextInputControllerOutlined!
    let regraDeDescontoTextInputController: MDCTextInputControllerOutlined!
    let descontoTextInputController: MDCTextInputControllerOutlined!
    let contratoTextInputController: MDCTextInputControllerOutlined!
    let observacaoTextInputController: MDCTextInputControllerOutlined!
    let pesoLiquidoTextInputController: MDCTextInputControllerOutlined!
    let pesoBrutoTextInputController: MDCTextInputControllerOutlined!
    let cepTextInputController: MDCTextInputControllerOutlined!
    // MARK: - Class routine functions
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        clientTextInputController = MDCTextInputControllerOutlined(textInput: clientTextInput)
        lojaTextInputController = MDCTextInputControllerOutlined(textInput: lojaTextInput)
        clienteDeEntregaTextInputController = MDCTextInputControllerOutlined(textInput: clienteDeEntregaTextInput)
        clientNameTextInputController = MDCTextInputControllerOutlined(textInput: clientNameTextInput)
        pvVinculadoTextInputController = MDCTextInputControllerOutlined(textInput: pvVinculadoTextInput)
        avalistaTextInputController = MDCTextInputControllerOutlined(textInput: avalistaTextInput)
        lojaAvalistaTextInputController = MDCTextInputControllerOutlined(textInput: lojaAvalistaTextInput)
        kitTextInputController = MDCTextInputControllerOutlined(textInput: kitTextInput)
        tipoDeClienteTextInputController = MDCTextInputControllerOutlined(textInput: tipoDeClienteTextInput)
        expressTextInputController = MDCTextInputControllerOutlined(textInput: expressTextInput)
        unidadeDeMedidaTextInputController = MDCTextInputControllerOutlined(textInput: unidadeDeMedidaTextInput)
        tipoDeFreteTextInputController = MDCTextInputControllerOutlined(textInput: tipodeFreteTextInput)
        transportadoraTextInputController = MDCTextInputControllerOutlined(textInput: transportadoraTextInput)
        condicaoDePagamentoTextInputController = MDCTextInputControllerOutlined(textInput: condicaoDePagamentoTextInput)
        descDasCondicoesDePagamentoTextInputController = MDCTextInputControllerOutlined(textInput: descDasCondicoesDePagamentoTextInput)
        regraDeDescontoTextInputController = MDCTextInputControllerOutlined(textInput: regraDeDescontoTextInput)
        descontoTextInputController = MDCTextInputControllerOutlined(textInput: descontoTextInput)
        contratoTextInputController = MDCTextInputControllerOutlined(textInput: contratoTextInput)
        observacaoTextInputController = MDCTextInputControllerOutlined(textInput: observacaoTextInput)
        pesoLiquidoTextInputController = MDCTextInputControllerOutlined(textInput: pesoLiquidoTextInput)
        pesoBrutoTextInputController = MDCTextInputControllerOutlined(textInput: pesoBrutoTextInput)
        cepTextInputController = MDCTextInputControllerOutlined(textInput: cepTextInput)
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
        
        scrollView.addSubview(lojaTextInput)
        lojaTextInput.topAnchor.constraint(equalTo: clientTextInput.bottomAnchor, constant: 20).isActive = true
        lojaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        lojaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(clienteDeEntregaTextInput)
        clienteDeEntregaTextInput.topAnchor.constraint(equalTo: lojaTextInput.bottomAnchor, constant: 20).isActive = true
        clienteDeEntregaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        clienteDeEntregaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(clientNameTextInput)
        clientNameTextInput.topAnchor.constraint(equalTo: clienteDeEntregaTextInput.bottomAnchor, constant: 20).isActive = true
        clientNameTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        clientNameTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(pvVinculadoTextInput)
        pvVinculadoTextInput.topAnchor.constraint(equalTo: clientNameTextInput.bottomAnchor, constant: 20).isActive = true
        pvVinculadoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pvVinculadoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(avalistaTextInput)
        avalistaTextInput.topAnchor.constraint(equalTo: pvVinculadoTextInput.bottomAnchor, constant: 20).isActive = true
        avalistaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        avalistaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(lojaAvalistaTextInput)
        lojaAvalistaTextInput.topAnchor.constraint(equalTo: avalistaTextInput.bottomAnchor, constant: 20).isActive = true
        lojaAvalistaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        lojaAvalistaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(kitTextInput)
        kitTextInput.topAnchor.constraint(equalTo: lojaAvalistaTextInput.bottomAnchor, constant: 20).isActive = true
        kitTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        kitTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(tipoDeClienteTextInput)
        tipoDeClienteTextInput.topAnchor.constraint(equalTo: kitTextInput.bottomAnchor, constant: 20).isActive = true
        tipoDeClienteTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        tipoDeClienteTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(expressTextInput)
        expressTextInput.topAnchor.constraint(equalTo: tipoDeClienteTextInput.bottomAnchor, constant: 20).isActive = true
        expressTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        expressTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(unidadeDeMedidaTextInput)
        unidadeDeMedidaTextInput.topAnchor.constraint(equalTo: expressTextInput.bottomAnchor, constant: 20).isActive = true
        unidadeDeMedidaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        unidadeDeMedidaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(tipodeFreteTextInput)
        tipodeFreteTextInput.topAnchor.constraint(equalTo: unidadeDeMedidaTextInput.bottomAnchor, constant: 20).isActive = true
        tipodeFreteTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        tipodeFreteTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(transportadoraTextInput)
        transportadoraTextInput.topAnchor.constraint(equalTo: tipodeFreteTextInput.bottomAnchor, constant: 20).isActive = true
        transportadoraTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        transportadoraTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(condicaoDePagamentoTextInput)
        condicaoDePagamentoTextInput.topAnchor.constraint(equalTo: transportadoraTextInput.bottomAnchor, constant: 20).isActive = true
        condicaoDePagamentoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        condicaoDePagamentoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(descDasCondicoesDePagamentoTextInput)
        descDasCondicoesDePagamentoTextInput.topAnchor.constraint(equalTo: condicaoDePagamentoTextInput.bottomAnchor, constant: 20).isActive = true
        descDasCondicoesDePagamentoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        descDasCondicoesDePagamentoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(regraDeDescontoTextInput)
        regraDeDescontoTextInput.topAnchor.constraint(equalTo: descDasCondicoesDePagamentoTextInput.bottomAnchor, constant: 20).isActive = true
        regraDeDescontoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        regraDeDescontoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(descontoTextInput)
        descontoTextInput.topAnchor.constraint(equalTo: regraDeDescontoTextInput.bottomAnchor, constant: 20).isActive = true
        descontoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        descontoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(contratoTextInput)
        contratoTextInput.topAnchor.constraint(equalTo: descontoTextInput.bottomAnchor, constant: 20).isActive = true
        contratoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        contratoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(observacaoTextInput)
        observacaoTextInput.topAnchor.constraint(equalTo: contratoTextInput.bottomAnchor, constant: 20).isActive = true
        observacaoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        observacaoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    
        scrollView.addSubview(pesoLiquidoTextInput)
        pesoLiquidoTextInput.topAnchor.constraint(equalTo: observacaoTextInput.bottomAnchor, constant: 20).isActive = true
        pesoLiquidoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pesoLiquidoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(pesoBrutoTextInput)
        pesoBrutoTextInput.topAnchor.constraint(equalTo: pesoLiquidoTextInput.bottomAnchor, constant: 20).isActive = true
        pesoBrutoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pesoBrutoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    
        scrollView.addSubview(cepTextInput)
        cepTextInput.topAnchor.constraint(equalTo: pesoBrutoTextInput.bottomAnchor, constant: 20).isActive = true
        cepTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        cepTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
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
