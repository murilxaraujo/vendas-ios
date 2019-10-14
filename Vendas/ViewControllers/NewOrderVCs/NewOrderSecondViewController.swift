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
    
    let unidadeDeMedidas = ["Kg", "Peça"]
    let tiposDeFrete = ["CIF", "FOB"]
    
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
        input.keyboardType = .numberPad
        return input
    }()
    
    let kitSwitch: UISwitch = {
        let input = UISwitch()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.isOn = true
        input.addTarget(self, action: #selector(kitValueChanged(_:)), for: .valueChanged)
        return input
    }()
    
    let expressSwitch: UISwitch = {
        let input = UISwitch()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(expressValueChanged(_:)), for: .valueChanged);
        return input
    }()
    
    let unidadeDeMedidaSegmentedControl: UISegmentedControl = {
        let input = UISegmentedControl(items: ["Kg", "Peça"])
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(unidadeDeMedidaChangedValue(_:)), for: .valueChanged)
        return input
    }()
    
    let tipodeFreteSegmentedControl: UISegmentedControl = {
        let input = UISegmentedControl(items: ["CIF", "FOB"])
        input.translatesAutoresizingMaskIntoConstraints = false
        input.addTarget(self, action: #selector(tipoDeFreteChangedValue(_:)), for: .valueChanged)
        return input
    }()
    
    let transportadoraTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Transportadora"
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
        input.keyboardType = UIKeyboardType.decimalPad
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
        input.isEnabled = false
        return input
    }()
    
    let pesoBrutoTextInput: MDCTextField = {
        let input = MDCTextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Peso bruto"
        input.isEnabled = false
        return input
    }()
    
    let clientTextInputController: MDCTextInputControllerOutlined!
    let lojaTextInputController: MDCTextInputControllerOutlined!
    let clienteDeEntregaTextInputController: MDCTextInputControllerOutlined!
    let clientNameTextInputController: MDCTextInputControllerOutlined!
    let pvVinculadoTextInputController: MDCTextInputControllerOutlined!
    let transportadoraTextInputController: MDCTextInputControllerOutlined!
    let condicaoDePagamentoTextInputController: MDCTextInputControllerOutlined!
    let descDasCondicoesDePagamentoTextInputController: MDCTextInputControllerOutlined!
    let regraDeDescontoTextInputController: MDCTextInputControllerOutlined!
    let descontoTextInputController: MDCTextInputControllerOutlined!
    let observacaoTextInputController: MDCTextInputControllerOutlined!
    let pesoLiquidoTextInputController: MDCTextInputControllerOutlined!
    let pesoBrutoTextInputController: MDCTextInputControllerOutlined!
    // MARK: - Class routine functions
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        clientTextInputController = MDCTextInputControllerOutlined(textInput: clientTextInput)
        lojaTextInputController = MDCTextInputControllerOutlined(textInput: lojaTextInput)
        clienteDeEntregaTextInputController = MDCTextInputControllerOutlined(textInput: clienteDeEntregaTextInput)
        clientNameTextInputController = MDCTextInputControllerOutlined(textInput: clientNameTextInput)
        pvVinculadoTextInputController = MDCTextInputControllerOutlined(textInput: pvVinculadoTextInput)
        transportadoraTextInputController = MDCTextInputControllerOutlined(textInput: transportadoraTextInput)
        condicaoDePagamentoTextInputController = MDCTextInputControllerOutlined(textInput: condicaoDePagamentoTextInput)
        descDasCondicoesDePagamentoTextInputController = MDCTextInputControllerOutlined(textInput: descDasCondicoesDePagamentoTextInput)
        regraDeDescontoTextInputController = MDCTextInputControllerOutlined(textInput: regraDeDescontoTextInput)
        descontoTextInputController = MDCTextInputControllerOutlined(textInput: descontoTextInput)
        observacaoTextInputController = MDCTextInputControllerOutlined(textInput: observacaoTextInput)
        pesoLiquidoTextInputController = MDCTextInputControllerOutlined(textInput: pesoLiquidoTextInput)
        pesoBrutoTextInputController = MDCTextInputControllerOutlined(textInput: pesoBrutoTextInput)
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
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1300)
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
        lojaTextInput.topAnchor.constraint(equalTo: clientTextInput.bottomAnchor, constant: 0).isActive = true
        lojaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        lojaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(clienteDeEntregaTextInput)
        let clienteDeEntregaButton = UIButton(type: .custom)
        clienteDeEntregaButton.setImage(UIImage(named: "round_search_black_24pt"), for: .normal)
        clienteDeEntregaButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28);
        clienteDeEntregaButton.addTarget(self, action: #selector(openDeliveryClientSelection(_:)), for: .touchUpInside)
        clienteDeEntregaTextInput.topAnchor.constraint(equalTo: lojaTextInput.bottomAnchor, constant: 0).isActive = true
        clienteDeEntregaTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        clienteDeEntregaTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        clienteDeEntregaTextInput.rightView = clienteDeEntregaButton
        clienteDeEntregaTextInput.rightViewMode = .always
        
        scrollView.addSubview(clientNameTextInput)
        clientNameTextInput.topAnchor.constraint(equalTo: clienteDeEntregaTextInput.bottomAnchor, constant: 0).isActive = true
        clientNameTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        clientNameTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(pvVinculadoTextInput)
        pvVinculadoTextInput.topAnchor.constraint(equalTo: clientNameTextInput.bottomAnchor, constant: 0).isActive = true
        pvVinculadoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pvVinculadoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(kitSwitch)
        kitSwitch.topAnchor.constraint(equalTo: pvVinculadoTextInput.bottomAnchor, constant: 0).isActive = true
        kitSwitch.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let kitSwitchLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Kit"
            return label
        }()
        
        scrollView.addSubview(kitSwitchLabel)
        kitSwitchLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor,constant: 20).isActive = true
        kitSwitchLabel.centerYAnchor.constraint(equalTo: kitSwitch.centerYAnchor).isActive = true
        kitSwitchLabel.rightAnchor.constraint(equalTo: kitSwitch.leftAnchor, constant: -20).isActive = true
        
        
        scrollView.addSubview(expressSwitch)
        expressSwitch.topAnchor.constraint(equalTo: kitSwitch.bottomAnchor, constant: 20).isActive = true
        expressSwitch.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let expressSwitchLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Express"
            return label
        }()
        
        scrollView.addSubview(expressSwitchLabel)
        expressSwitchLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        expressSwitchLabel.centerYAnchor.constraint(equalTo: expressSwitch.centerYAnchor).isActive = true
        
        scrollView.addSubview(unidadeDeMedidaSegmentedControl)
        unidadeDeMedidaSegmentedControl.topAnchor.constraint(equalTo: expressSwitch.bottomAnchor, constant: 20).isActive = true
        unidadeDeMedidaSegmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let unidadeDeMedidaSegmentedControlLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Unidade de medida"
            return label
        }()
        
        scrollView.addSubview(unidadeDeMedidaSegmentedControlLabel)
        unidadeDeMedidaSegmentedControlLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        unidadeDeMedidaSegmentedControlLabel.centerYAnchor.constraint(equalTo: unidadeDeMedidaSegmentedControl.centerYAnchor).isActive = true
        
        scrollView.addSubview(tipodeFreteSegmentedControl)
        tipodeFreteSegmentedControl.topAnchor.constraint(equalTo: unidadeDeMedidaSegmentedControl.bottomAnchor, constant: 20).isActive = true
        tipodeFreteSegmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let tipodeFreteSegmentedControlLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Tipo de frete"
            return label
        }()
        
        scrollView.addSubview(tipodeFreteSegmentedControlLabel)
        tipodeFreteSegmentedControlLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        tipodeFreteSegmentedControlLabel.centerYAnchor.constraint(equalTo: tipodeFreteSegmentedControl.centerYAnchor).isActive = true
        
        scrollView.addSubview(transportadoraTextInput)
        let transportadoraTextFieldButton = UIButton(type: .custom)
        transportadoraTextFieldButton.setImage(UIImage(named: "round_search_black_24pt"), for: .normal)
        transportadoraTextFieldButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28);
        transportadoraTextFieldButton.addTarget(self, action: #selector(openTransportadoraSelection(_:)), for: .touchUpInside)
        transportadoraTextInput.topAnchor.constraint(equalTo: tipodeFreteSegmentedControl.bottomAnchor, constant: 20).isActive = true
        transportadoraTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        transportadoraTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        transportadoraTextInput.rightView = transportadoraTextFieldButton
        transportadoraTextInput.rightViewMode = .always
        
        scrollView.addSubview(condicaoDePagamentoTextInput)
        let condPagamentoTextFieldInputButton = UIButton(type: .custom)
        condPagamentoTextFieldInputButton.setImage(UIImage(named: "round_search_black_24pt"), for: .normal)
        condPagamentoTextFieldInputButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        condPagamentoTextFieldInputButton.addTarget(self, action: #selector(openCondsPagamentoSelection(_:)), for: .touchUpInside)
        condicaoDePagamentoTextInput.topAnchor.constraint(equalTo: transportadoraTextInput.bottomAnchor, constant: 0).isActive = true
        condicaoDePagamentoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        condicaoDePagamentoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        condicaoDePagamentoTextInput.rightView = condPagamentoTextFieldInputButton
        condicaoDePagamentoTextInput.rightViewMode = .always
        
        scrollView.addSubview(descDasCondicoesDePagamentoTextInput)
        descDasCondicoesDePagamentoTextInput.topAnchor.constraint(equalTo: condicaoDePagamentoTextInput.bottomAnchor, constant: 0).isActive = true
        descDasCondicoesDePagamentoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        descDasCondicoesDePagamentoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(regraDeDescontoTextInput)
        let regrasDeDescontoTextFieldInputButton = UIButton(type: .custom)
        regrasDeDescontoTextFieldInputButton.setImage(UIImage(named: "round_search_black_24pt"), for: .normal)
        regrasDeDescontoTextFieldInputButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        regrasDeDescontoTextFieldInputButton.addTarget(self, action: #selector(openRegraDeDescontoSelection(_:)), for: .touchUpInside)
        regraDeDescontoTextInput.topAnchor.constraint(equalTo: descDasCondicoesDePagamentoTextInput.bottomAnchor, constant: 0).isActive = true
        regraDeDescontoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        regraDeDescontoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        regraDeDescontoTextInput.rightView = regrasDeDescontoTextFieldInputButton
        regraDeDescontoTextInput.rightViewMode = .always
        
        scrollView.addSubview(descontoTextInput)
        descontoTextInput.topAnchor.constraint(equalTo: regraDeDescontoTextInput.bottomAnchor, constant: 0).isActive = true
        descontoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        descontoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(observacaoTextInput)
        observacaoTextInput.topAnchor.constraint(equalTo: descontoTextInput.bottomAnchor, constant: 0).isActive = true
        observacaoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        observacaoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    
        scrollView.addSubview(pesoLiquidoTextInput)
        pesoLiquidoTextInput.topAnchor.constraint(equalTo: observacaoTextInput.bottomAnchor, constant: 0).isActive = true
        pesoLiquidoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pesoLiquidoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(pesoBrutoTextInput)
        pesoBrutoTextInput.topAnchor.constraint(equalTo: pesoLiquidoTextInput.bottomAnchor, constant: 0).isActive = true
        pesoBrutoTextInput.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pesoBrutoTextInput.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let nextButton = UIBarButtonItem(title: "Próximo", style: .plain, target: self, action: #selector(nextPage(_:)))
        self.navigationItem.rightBarButtonItem = nextButton
    }
    
    func onClientSelected(_ client: Client) {
        newOrderItem?.client = client
        clientTextInput.text = client.codigo
        lojaTextInput.text = client.loja
        clienteDeEntregaTextInput.text = client.codigo
        clientNameTextInput.text = client.Nome
        fillInfoWithClientDetais(client)
    }
    
    func onDeliveryClientSelected(_ client: Client) {
        clienteDeEntregaTextInput.text = client.codigo
        clientNameTextInput.text = client.Nome
    }
    
    func onTransportadoraSelected(_ transportadora: Transportadora) {
        newOrderItem?.transportadora = transportadora.codigo
        transportadoraTextInput.text = transportadora.nome
    }
    
    func onCondPagamentoSelected(_ condPagamento: CondicaoDePagamento) {
        newOrderItem?.condPagamento = condPagamento.codigo
        condicaoDePagamentoTextInput.text = condPagamento.codigo
        descDasCondicoesDePagamentoTextInput.text = condPagamento.descricao
    }
    
    func onRegrasDeDescontoSelected(_ regra: RegraDeDesconto) {
        regraDeDescontoTextInput.text = regra.descricao
        newOrderItem?.regraDeDesconto = regra.codigo
    }
    
    @objc fileprivate func openClientSelection(_ sender: Any) {
        let vc = ClientSelectionViewController()
        vc.mainViewController = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc fileprivate func openDeliveryClientSelection(_ sender: Any) {
        let vc = DeliveryClientSelectionViewController()
        vc.mainViewController = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc fileprivate func openTransportadoraSelection(_ sender: Any) {
        let vc = TransportadorasTableViewController()
        vc.previousVC = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc fileprivate func openCondsPagamentoSelection(_ sender: Any) {
        let vc = CondicaoDePagamentoTableViewController()
        vc.previousVC = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    @objc fileprivate func openRegraDeDescontoSelection(_ sender: Any) {
        let vc = RegraDeDescontoTableViewController()
        vc.previousVC = self
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    fileprivate func fillInfoWithClientDetais(_ client: Client) {
        
    }
    
    @objc fileprivate func nextPage(_ sender: Any) {
        let vc = NewOrderThirdViewController()
        vc.previousVC = self
        vc.newOrderItem = newOrderItem
        vc.newOrderItem?.obs = observacaoTextInput.text ?? ""
        vc.newOrderItem?.desconto = descontoTextInput.text ?? ""
        vc.newOrderItem?.kit = {
            if kitSwitch.isOn {
                return "S"
            }
            return "N"
        }()
        vc.newOrderItem?.express = {
            if expressSwitch.isOn {
                return "S"
            }
            return "N"
        }()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func expressValueChanged(_ sender: UISwitch) {
        if (sender.isOn) {
            unidadeDeMedidaSegmentedControl.selectedSegmentIndex = 1
            unidadeDeMedidaSegmentedControl.setEnabled(false, forSegmentAt: 0)
            newOrderItem?.express = "S"
        } else {
            unidadeDeMedidaSegmentedControl.setEnabled(true, forSegmentAt: 0)
            newOrderItem?.express = "N"
        }
    }
    
    @objc func kitValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            newOrderItem?.kit = "S"
        } else {
            newOrderItem?.kit = "N"
        }
    }
    
    //MARK: - Segmented controls targets
    
    @objc func unidadeDeMedidaChangedValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            newOrderItem?.um = "KG"
        } else {
            newOrderItem?.um = "PC"
        }
    }
    
    @objc func tipoDeFreteChangedValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            newOrderItem?.tipoDeFrete = "C"
        } else {
            newOrderItem?.tipoDeFrete = "F"
        }
    }
    
}
