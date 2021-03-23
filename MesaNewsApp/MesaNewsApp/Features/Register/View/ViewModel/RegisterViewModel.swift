//
//  RegisterViewModel.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit

final class RegisterViewModel: NSObject {
    
    private let model: RegisterModel
    private var viewController: UIViewController
    
    init(model: RegisterModel = .init(), viewController: UIViewController) {
        self.model = model
        self.viewController = viewController
    }
    
    func requestRegister(data: [String : Any], completion: ((_ object: Any) -> Void)?) {
        
        self.service(controller: viewController, operation: .signup, parameters: data, type: RegisterModel.self) { (response) in
            
            if let error = response as? NSError {
                completion?(error)

            } else if let server_response = response as? Error {
                completion?(server_response)
                
            } else {
                
                completion?(response)
            }
        }
    }
}
