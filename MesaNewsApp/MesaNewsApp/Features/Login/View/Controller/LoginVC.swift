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
        
        let email = loginView.getEmailText()
        let password = loginView.getPasswordText()
        
        if email.count > 0 && password.count > 0 && email.isValidEmail() {
            
            viewModelLogin = LoginViewModel(model: .init(), viewController: self)
            
            viewModelLogin?.requestAuthorization(email: email, password: password, completion: { (response) in
                
                if let e = response as? NSError {
                    self.setSnackBarText(e.localizedDescription)
                } else if let server_response = response as? Server_Response {
                    if let mssg = server_response.mssg {
                        self.setSnackBarText(mssg)
                    }
                } else {
                    if let jResult = response as? LoginModel {
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
    
    func createAnAccount() {
        
        let registerVC = RegisterVC()
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
