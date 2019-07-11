//
//  NewClientViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController {
    // MARK: - Variables and constants
    
    // MARK: - View elements
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Class routine funcions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }
    
    // MARK: - Functions

    func setupViewElements() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
