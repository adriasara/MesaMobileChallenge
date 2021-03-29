//
//  LoginViewDelegate.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 29/03/21.
//

import UIKit

extension LoginView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1 {
            passwordBecomeFirstResponder()
        } else if textField.tag == 2 {
            passwordResignFirstResponder()
        }
        
        return true
    }
}
