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

class UploadViewController: UIViewController {

    // MARK: - Variables and constants
    
    var previousVC: SignatureCollectorViewController?
    var orderItem: NewOrder?
    
    // MARK: - View elements
    
    var loadingAnimation: AnimationView = {
        let lot = AnimationView()
        lot.translatesAutoresizingMaskIntoConstraints = false
        lot.loopMode = LottieLoopMode.loop
        return lot
    }()
    
    var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Class routine functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAnimation.animation = Animation.named("loader")
        // Do any additional setup after loading the view.
        self.view.addSubview(loadingAnimation)
        loadingAnimation.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
        loadingAnimation.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        loadingAnimation.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        loadingAnimation.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.view.addSubview(loadingLabel)
        loadingLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: loadingAnimation.bottomAnchor, constant: 40).isActive = true
        
        loadingAnimation.play()
    }

}
