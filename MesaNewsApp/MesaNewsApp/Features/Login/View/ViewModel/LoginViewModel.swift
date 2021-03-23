//
//  LoginViewModel.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit

final class LoginViewModel: NSObject {
    
    private let model: LoginModel
    private var viewController: UIViewController
    
    init(model: LoginModel = .init(), viewController: UIViewController) {
        self.model = model
        self.viewController = viewController
    }
    
    func requestAuthorization(email: String, password: String, completion: ((_ object: Any) -> Void)?) {
        
        self.service(controller: viewController, operation: .signin, parameters: ["email" : email, "password" : password], type: LoginModel.self) { (response) in
            
            if let error = response as? NSError {
                completion?(error)
            } else if let server_response = response as? Error {
                completion?(server_response)
            } else {
                completion?(response)
            }
        }
    }
    
    static var Server_Authorization: LoginModel? {
        get {

            guard let data = UserDefaults.standard.object(forKey: "Server_Authorization_Response") as? Data else {
                return nil
            }

            return try? JSONDecoder().decode(LoginModel.self, from: data)

        } set {

            if let data = newValue  {
                UserDefaults.standard.set(try? JSONEncoder().encode(data), forKey: "Server_Authorization_Response")

            } else {

                UserDefaults.standard.set(nil, forKey: "Server_Authorization_Response")
            }
        }
    }
}
