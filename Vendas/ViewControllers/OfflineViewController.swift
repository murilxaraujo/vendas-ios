//
//  OfflineViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 11/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import Lottie

class OfflineViewController: UIViewController {
    
    // MARK: - View elements
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.loopMode = .playOnce
        return animation
    }()
    
    let offlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Você está offline e não possui backup para usar o aplicativo sem internet, fique online antes de usar a aplicação"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Class routine functions

    override func viewDidLoad() {
        super.viewDidLoad()

       setupViewElements()
    }
    
    // MARK: - Methods
    
    func setupViewElements() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(animationView)
        animationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        animationView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        animationView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        let animation = Animation.named("offline")
        animationView.animation = animation
        animationView.play(fromFrame: 70, toFrame: 180, loopMode: .playOnce, completion: nil)
        
        self.view.addSubview(offlineLabel)
        offlineLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        offlineLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        offlineLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
}
