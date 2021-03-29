//
//  RegisterViewDelegate.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 29/03/21.
//

import UIKit

extension RegisterView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            emailBecomeFirstResponder()
        case 2:
            passwordBecomeFirstResponder()
        case 3:
            confirmPasswordBecomeFirstResponder()
        case 4:
            confirmPasswordResignFirstResponder()
        default:
            break
        }
        
        return true
    }
}
