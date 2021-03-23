//
//  LoginVC.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit

final class LoginVC: UIViewController {
    
    let loginView: LoginView = LoginView(frame: .zero)
    var viewModelLogin: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sv(loginView)
        loginView.delegate = self
        loginView.fillContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "login".localized()
    }
}

extension LoginVC: LoginDelegate {
    
    func login() {
        
        viewModelLogin = LoginViewModel(model: .init(), viewController: self)
        
        viewModelLogin?.requestAuthorization(email: loginView.getEmailText(), password: loginView.getPasswordText(), completion: { (response) in
            
            if let e = response as? NSError {
                self.setSnackBarText(e.localizedDescription)
            } else if let server_response = response as? Server_Response {
                self.setSnackBarText(server_response.mssg ?? "Error")
            } else {
                if let jResult = response as? LoginModel {
                    if let token = jResult.token, !token.isEmpty {
                        
                        print("login")
                    }
                }
            }
        })
    }
    
    func createAnAccount() {
        
        let registerVC = RegisterVC()
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
