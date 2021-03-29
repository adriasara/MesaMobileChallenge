//
//  RegisterView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit
import MaterialComponents
import Stevia

protocol RegisterDelegate: NSObjectProtocol {
    func register()
}

final class RegisterView: UIView {
    
    weak var delegate: RegisterDelegate?
    
    private lazy var nameTextField: MDCTextField = {
        let nameTextField = MDCTextField(frame: .zero)
        nameTextField.placeholder = "name".localized()
        nameTextField.autocapitalizationType = .words
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self
        nameTextField.tag = 1
        return nameTextField
    }()
    
    private lazy var emailTextField: MDCTextField = {
        let emailTextField = MDCTextField(frame: .zero)
        emailTextField.placeholder = "email".localized()
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        emailTextField.tag = 2
        return emailTextField
    }()
    
    private lazy var passwordTextField: MDCTextField = {
        let passwordTextField = MDCTextField(frame: .zero)
        passwordTextField.placeholder = "password".localized()
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .next
        passwordTextField.trailingViewMode = .always
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.tag = 3
        return passwordTextField
    }()
    
    private lazy var confirmPasswordTextField: MDCTextField = {
        let confirmPasswordTextField = MDCTextField(frame: .zero)
        confirmPasswordTextField.placeholder = "confirm_password".localized()
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.returnKeyType = .done
        confirmPasswordTextField.trailingViewMode = .always
        confirmPasswordTextField.textContentType = .oneTimeCode
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.delegate = self
        confirmPasswordTextField.tag = 4
        return confirmPasswordTextField
    }()
    
    private lazy var registerButton: UIButton = {
        let registerButton = UIButton(frame: .zero)
        registerButton.backgroundColor = StyleKit.colors.lightGray
        registerButton.titleLabel?.font = StyleKit.fonts.normalText
        registerButton.setTitleColor(StyleKit.colors.black, for: .normal)
        registerButton.layer.cornerRadius = StyleKit.borders.buttons
        registerButton.setTitle("register".localized(), for: .normal)
        registerButton.isUserInteractionEnabled = false
        return registerButton
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
        
        addActions()
        subviews()
        layout()
    }
    
    private func subviews() {
        
        sv([nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, registerButton])
    }
    
    private func layout() {

        nameTextField.left(15).right(15).top(20%)

        emailTextField.left(15).right(15).Top == nameTextField.Bottom
        
        passwordTextField.left(15).right(15).Top == emailTextField.Bottom

        confirmPasswordTextField.left(15).right(15).Top == passwordTextField.Bottom

        registerButton.centerHorizontally().bottom(40).height(53).left(40).right(40)
    }
    
    private func addActions() {
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        registerButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChanged() {
        
        guard let name = nameTextField.text else { return }
        guard let user = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        if name.count > 0 && user.count > 0 && password.count > 0 && user.isValidEmail() && password == confirmPassword {
            registerButton.isUserInteractionEnabled = true
            registerButton.backgroundColor = StyleKit.colors.white
        } else {
            registerButton.isUserInteractionEnabled = false
            registerButton.backgroundColor = StyleKit.colors.lightGray
        }
    }

    @objc private func registerAction() {
        delegate?.register()
    }
    
    func getNameText() -> String {
        
        return nameTextField.text ?? ""
    }
    
    func getEmailText() -> String {
        
        return emailTextField.text ?? ""
    }
    
    func getPasswordText() -> String {
        
        return passwordTextField.text ?? ""
    }
    
    func getConfirmPasswordText() -> String {
        return confirmPasswordTextField.text ?? ""
    }
    
    func emailBecomeFirstResponder() {
        emailTextField.becomeFirstResponder()
    }
    
    func passwordBecomeFirstResponder() {
        passwordTextField.becomeFirstResponder()
    }
    
    func confirmPasswordBecomeFirstResponder() {
        confirmPasswordTextField.becomeFirstResponder()
    }
    
    func confirmPasswordResignFirstResponder() {
        confirmPasswordTextField.resignFirstResponder()
        delegate?.register()
    }
}
