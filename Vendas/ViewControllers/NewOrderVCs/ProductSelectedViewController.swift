//
//  ProductSelectedViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 09/09/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialTextFields

class ProductSelectedViewController: UIViewController {
    
    //Variables and constants
    var selectedUM = ""
    var saldo: String = ""
    var price: String = ""
    var clientID: String?
    var clientLoja: String?
    var productID: String?
    var product: Product?
    var previousVC: ItemsSelectionViewController?
    
    let productQuantityTextView: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .decimalPad
        tf.placeholder = "Quantidade"
        return tf
    }()
    
    let closeButton: MDCFloatingButton = {
        let button = MDCFloatingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "round_close_black_24pt"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .lightGray
        //button.layer.cornerRadius = 15
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let priceText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "carregando..."
        return label
    }()
    
    let productQuantityTextViewController: MDCTextInputControllerOutlined!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getPrice()
        // Do any additional setup after loading the view.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        productQuantityTextViewController = MDCTextInputControllerOutlined(textInput: productQuantityTextView)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.isOpaque = false
        
        
        let modalView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            return view
        }()
        
        view.addSubview(modalView)
        modalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        modalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        modalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        let returnButton: MDCRaisedButton = {
            let button = MDCRaisedButton()
            button.setTitle("Adicionar", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(sendDataBack(_:)), for: .touchUpInside)
            return button
        }()
        
        modalView.addSubview(returnButton)
        returnButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        returnButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        returnButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        modalView.addSubview(productQuantityTextView)
        productQuantityTextView.bottomAnchor.constraint(equalTo: returnButton.topAnchor, constant: -5).isActive = true
        productQuantityTextView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        productQuantityTextView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
        let priceView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            view.layer.cornerRadius = 5
            
            let priceLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = .darkGray
                label.font = UIFont.systemFont(ofSize: 15)
                label.text = "Preço"
                return label
            }()
            
            view.addSubview(priceLabel)
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
            
            view.addSubview(priceText)
            priceText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            priceText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
            
            return view
        }()
        
        let saldoView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            view.layer.cornerRadius = 5
            
            let saldoLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 15)
                label.textColor = UIColor.darkGray
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "Saldo"
                return label
            }()
            
            let saldoText: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 20)
                label.text = "\(saldo) \(product?.primeiraunidade ?? "")"
                return label
            }()
            
            view.addSubview(saldoLabel)
            saldoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
            saldoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
            
            view.addSubview(saldoText)
            saldoText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
            saldoText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
            
            return view
        }()
        
        
        modalView.addSubview(priceView)
        if (product!.hasSecondMeasureUnit()) {
            priceView.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -50).isActive = true
        } else {
            priceView.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -15).isActive = true
        }
        priceView.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -15).isActive = true
        priceView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        priceView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -10).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        modalView.addSubview(saldoView)
        if (product!.hasSecondMeasureUnit()) {
            saldoView.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -50).isActive = true
        } else {
            saldoView.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -15).isActive = true
        }
        saldoView.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -15).isActive = true
        saldoView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 10).isActive = true
        saldoView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        saldoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //ViewHeight
        modalView.topAnchor.constraint(equalTo: priceView.topAnchor, constant: -20).isActive = true
        

        
        view.addSubview(closeButton)
        closeButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: modalView.topAnchor, constant: -20).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.addTarget(self, action: #selector(closeCurrentView(_:)), for: .touchUpInside)
        
        if (product!.hasSecondMeasureUnit()) {
            let unitylabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "Unidade de medida"
                return label
            }()
            
            modalView.addSubview(unitylabel)
            unitylabel.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -10).isActive = true
            unitylabel.leftAnchor.constraint(equalTo: returnButton.leftAnchor).isActive = true
            
            let unidadeSegmentedControl: UISegmentedControl = {
                let seg = UISegmentedControl(items: [product!.primeiraunidade, product!.segundaunidade])
                seg.selectedSegmentIndex = 0
                seg.translatesAutoresizingMaskIntoConstraints = false
                seg.addTarget(self, action: #selector(changeum(_:)), for: .valueChanged)
                return seg
            }()
            
            modalView.addSubview(unidadeSegmentedControl)
            unidadeSegmentedControl.bottomAnchor.constraint(equalTo: productQuantityTextView.topAnchor, constant: -10).isActive = true
            unidadeSegmentedControl.rightAnchor.constraint(equalTo: returnButton.rightAnchor).isActive = true
            
        }
    }
    
    @objc func sendDataBack(_ sender: Any) {
        var um = ""
        if (product!.hasSecondMeasureUnit()) {
            um = selectedUM
        } else {
            um = product!.primeiraunidade
        }
        let productin = ProdutoPedido(quantidade: Float("\(productQuantityTextView.text!)")!, produto: product!, price: price, selectedUM: um)
        previousVC?.onProductSelected(productin)
        closeCurrentView(sender)
    }
    
    @objc func closeCurrentView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeum(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedUM = product!.primeiraunidade
        } else {
            selectedUM = product!.segundaunidade
        }
    }
    
    func getPrice() {
        DataService.shared.getProductPrice(clientID: clientID!, clientLoja: clientLoja!, productID: productID!) { (price, error) in
            if error != nil {
                self.priceText.text = "erro"
                return
            }
            let discount = 100.0 - Double(self.previousVC!.formerViewController!.newOrderItem!.desconto)!
            let pricein = Double(price!)!*discount/100
            self.priceText.text = "R$ \(String(format: "%.2f", pricein))"
            self.price = "\(String(format: "%.2f", pricein))"
        }
    }
}
