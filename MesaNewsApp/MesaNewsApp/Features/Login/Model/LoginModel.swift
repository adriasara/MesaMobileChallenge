//
//  LoginModel.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit

final class LoginModel: Codable {
    
    var token: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case token
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        token = try? container.decode(String.self, forKey: .token)
    }
}
