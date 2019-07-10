//
//  ViewController.swift
//  Vendas
//
//  Created by Murilo Araujo on 01/07/19.
//  Copyright © 2019 Murilo Araujo. All rights reserved.
//

import UIKit
import Lottie

class LoadingScreenViewController: UIViewController {
    
    let networkSer = NetworkService()
    let authSer = AuthService()
    
    var animationView: AnimationView = {
        let av = AnimationView()
        av.loopMode = .loop
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Carregando..."
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    func loadInterface() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(animationView)
        animationView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -50).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        let animation = Animation.named("loading")
        animationView.animation = animation
        animationView.play()
        
        
        
        self.view.addSubview(loadingLabel)
        loadingLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 50).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        goToNextScreen()
    }

    func netWorkAvailable() -> Bool {
        var hasNetwork: Bool?
        
        do {
            hasNetwork = try networkSer.isNetworkAvailable()
        } catch {
            
        }
        
        if hasNetwork == nil {
            return true
        }
        
        return hasNetwork!
    }
    
    func goToNextScreen() {
        if netWorkAvailable() {
            //Device has internet
            print("Login credentials:", authSer.hasSavedLoginCredentials())
            if authSer.hasSavedLoginCredentials(){
                //Has saved credentials
                
                var user: User?
                
                do {
                    user = try authSer.authenticate(username: authSer.getSavedUsername(), password: authSer.getSavedPassword())
                } catch {
                    
                }
                
                if user == nil {
                    self.present(LoginViewController(), animated: true, completion: nil)
                    return
                } else {
                    authSer.saveUserID(id: user!.id)
                    self.present(HomeViewController(), animated: true, completion: nil)
                    
                }
                
            } else {
                //Does not have saved login credentials
                self.present(LoginViewController(), animated: true, completion: nil)
                
            }
            
        } else {
            //Has no network
        }
    }
    
}

