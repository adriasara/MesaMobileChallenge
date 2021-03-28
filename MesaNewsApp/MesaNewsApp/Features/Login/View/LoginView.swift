//
//  LoginView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit
import MaterialComponents
import Stevia

protocol LoginDelegate: NSObjectProtocol {
    func login()
    func createAnAccount()
}

final class LoginView: UIView {
    
    weak var delegate: LoginDelegate?
    
    private lazy var emailTextField: MDCTextField = {
        let emailTextField = MDCTextField(frame: .zero)
        emailTextField.placeholder = "email".localized()
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        return emailTextField
    }()
    
    private lazy var passwordTextField: MDCTextField = {
        let passwordTextField = MDCTextField(frame: .zero)
        passwordTextField.placeholder = "password".localized()
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        passwordTextField.trailingViewMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        return passwordTextField
    }()
    
    private lazy var createAnAccountButton: UIButton = {
        let createAnAccountButton = UIButton(frame: .zero)
        createAnAccountButton.backgroundColor = .clear
        createAnAccountButton.titleLabel?.font = StyleKit.fonts.boldText
        createAnAccountButton.setTitleColor(.blue, for: .normal)
        createAnAccountButton.setTitle("create_account".localized(), for: .normal)
        return createAnAccountButton
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(frame: .zero)
        loginButton.backgroundColor = StyleKit.colors.lightGray
        loginButton.titleLabel?.font = StyleKit.fonts.normalText
        loginButton.setTitleColor(StyleKit.colors.black, for: .normal)
        loginButton.layer.cornerRadius = StyleKit.borders.buttons
        loginButton.setTitle("login".localized(), for: .normal)
        loginButton.isUserInteractionEnabled = false
        return loginButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        subviews()
        layout()
        addActions()
    }
    
    private func subviews() {
        
        sv([emailTextField, passwordTextField, createAnAccountButton, loginButton])
    }
    
    private func layout() {

        emailTextField.left(15).right(15).top(20%)

        passwordTextField.left(15).right(15).Top == emailTextField.Bottom
        
        createAnAccountButton.right(15).Top == passwordTextField.Bottom + 10

        loginButton.centerHorizontally().bottom(40).height(53).left(40).right(40)
    }
    
    private func addActions() {
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        createAnAccountButton.addTarget(self, action: #selector(createAnAccount), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChanged() {
        
        guard let user = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if user.count > 0 && password.count > 0 && user.isValidEmail() {
            loginButton.isUserInteractionEnabled = true
            loginButton.backgroundColor = StyleKit.colors.white
        } else {
            loginButton.isUserInteractionEnabled = false
            loginButton.backgroundColor = StyleKit.colors.lightGray
        }
    }
    
    @objc private func loginAction() {
        delegate?.login()
    }
    
    @objc private func createAnAccount() {
        delegate?.createAnAccount()
    }
    
    func getEmailText() -> String {
        
        return emailTextField.text ?? ""
    }
    
    func getPasswordText() -> String {
        
        return passwordTextField.text ?? ""
    }
}

extension LoginView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        endEditing(true);
    }
}
