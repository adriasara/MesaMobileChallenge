//
//  Extensions.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit
import MaterialComponents
import Alamofire

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {

        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    func isValidEmail() -> Bool {
        
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
}

extension Dictionary {
    
    func prettyPrint() -> String {
        
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted), let string = String(data: data, encoding: .utf8) else {
            
            return String()
        }
        
        return string
    }
}

extension NSObject {

    func service<T: Codable>(loading: Bool = true, controller: UIViewController, operation: Server, parameters: Parameters? = nil, type: T.Type, completion: @escaping (Any) -> Void) {
        
        if loading {
            
            let loadController = LoadBarVC()
            
            loadController.modalTransitionStyle = .crossDissolve
            loadController.modalPresentationStyle = .overCurrentContext
            
            controller.present(loadController, animated: true) {
                ServerAPI.request(operation: operation, parameters: parameters, type: type) { (response) in
                    
                    loadController.dismiss(animated: loading) {
                        completion(response)
                    }
                }
            }
        } else {
            
            ServerAPI.request(operation: operation, parameters: parameters, type: type) { (response) in
                completion(response)
            }
        }
    }
}

extension UIViewController {
    
    private func presentSnackBar(isAutomaticallyDismisses: Bool = true, text: String, offSet: CGFloat? = nil) {
        
        /* to use iOS 13.0 */
        
        var bottomOffSet: CGFloat = .zero
        
        if #available(iOS 11.0, *) {
            bottomOffSet += view.safeAreaInsets.bottom
        } else {
            bottomOffSet += bottomLayoutGuide.length
        }
        
        if let value = offSet {
            bottomOffSet += value
        }
        
        if MDCSnackbarManager.hasMessagesShowingOrQueued() {
            MDCSnackbarManager.suspendAllMessages()
            MDCSnackbarManager.dismissAndCallCompletionBlocks(withCategory: nil)
        }
        
        MDCSnackbarManager.setBottomOffset(bottomOffSet)
        MDCSnackbarManager.setPresentationHostView(view.superview ?? view)
        
        let message: MDCSnackbarMessage = {
            let m = MDCSnackbarMessage(text: text)
            m.duration = MDCSnackbarMessageDurationMax
            m.automaticallyDismisses = isAutomaticallyDismisses
            
            return m
        }()
        
        MDCSnackbarManager.show(message)
    }
    
    func setSnackBarText(_ text: String) {
        
        presentSnackBar(text: text)
    }
}
