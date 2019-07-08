//
//  HomeViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 08/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func newOrder(sender: Any) {
        let vc = UINavigationController(rootViewController: NewOrderViewController())
        self.show(vc, sender: nil)
    }

}
