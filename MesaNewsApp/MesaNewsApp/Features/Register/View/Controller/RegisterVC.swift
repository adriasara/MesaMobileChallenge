//
//  RegisterVC.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit

final class RegisterVC: UIViewController {
    
    let registerView: RegisterView = RegisterView(frame: .zero)
    var viewModelRegister: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sv(registerView)
        registerView.delegate = self
        registerView.fillContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "register".localized()
    }
}

extension RegisterVC: RegisterDelegate {
    
    func register() {
        
        viewModelRegister = RegisterViewModel(model: .init(), viewController: self)
        
        viewModelRegister?.requestRegister(data: ["name" : registerView.getNameText(), "email" : registerView.getEmailText(), "password" : registerView.getPasswordText()], completion: { (response) in
            
            if let e = response as? NSError {
                self.setSnackBarText(e.localizedDescription)
            } else if let server_response = response as? Server_Response {
                self.setSnackBarText(server_response.mssg ?? "Error")
            } else {
                if let jResult = response as? RegisterModel {
                    if let token = jResult.token, !token.isEmpty {
                        
                        print("register")
                    }
                }
            }
        })
    }
}
