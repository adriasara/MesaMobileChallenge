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
        
        let name = registerView.getNameText()
        let email = registerView.getEmailText()
        let password = registerView.getPasswordText()
        let confirmPassword = registerView.getConfirmPasswordText()
        
        if name.count > 0 && email.count > 0 && password.count > 0 && email.isValidEmail() && password == confirmPassword {
            
            viewModelRegister = RegisterViewModel(model: .init(), viewController: self)
            
            viewModelRegister?.requestRegister(data: ["name" : name, "email" : email, "password" : password], completion: { (response) in
                
                if let e = response as? NSError {
                    self.setSnackBarText(e.localizedDescription)
                } else if let server_response = response as? Server_Response {
                    if let mssg = server_response.mssg {
                        self.setSnackBarText(mssg)
                    }
                } else {
                    if let jResult = response as? RegisterModel {
                        if let token = jResult.token, !token.isEmpty {
                            let feedVC = FeedVC()
                            self.callStoryboard(vc: feedVC)
                        }
                    }
                }
            })
        } else {
            self.setSnackBarText("fill_fields".localized())
        }
    }
}
