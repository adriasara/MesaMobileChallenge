//
//  Server.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit
import Alamofire

enum Server: RawRepresentable {
    
    static var urlBase = ("https://mesa-news-api.herokuapp.com/")

    case signin, signup
    
    typealias RawValue = (url: String, method: HTTPMethod, encoding: URLEncoding)
    
    init?(rawValue: RawValue) {
        return nil
    }
    
    var rawValue: RawValue {
        
        switch self {
            
        case .signin: return ("v1/client/auth/signin", .post, .queryString)
        case .signup: return ("v1/client/auth/signup", .post, .queryString)
            
        }
    }
}

class Server_Response: Codable {
    
    var code: String?
    var mssg: String?
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case mssg = "message"
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try? container.decode(String.self, forKey: .code)
        mssg = try? container.decode(String.self, forKey: .mssg)
    }
}

class ServerAPI {
    
    private static var dataRequest: DataRequest?
    
    private static let alamofireManager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        return Alamofire.Session(configuration: configuration)
    }()
    
    static func cancelRequest() {
        
        self.dataRequest?.cancel()
    }
    
    static func request(operation: Server, parameters: Parameters? = nil, completion: ((_ object: Any) -> Void)?) {
        
        ServerAPI.request(operation: operation, parameters: parameters, type: Server_Response.self) { (response) in
            
            completion?(response)
            
        }
    }

    static func request<T: Codable>(operation: Server, parameters: Parameters? = nil, type: T.Type, completion: ((_ object: Any) -> Void)?) {
        
        func debugRequest(method: String, url: String, jsonS: String, error: String?, jsonR: String) {
            
            print("\n----------")
            
            print("\n🔴 A_TOKEN: " + (LoginViewModel.Server_Authorization?.token ?? "❌"))
            
            print("\n⚫️ " + method + " - " + url)
            
            if !jsonS.isEmpty {
                
                print("\n🔵 PRMT: " + jsonS)
            }
            
            if let e = error {
                
                print("\n⚠️ ERRO: " + e)
                
            } else  {
                
                print("\n💚 JSON " + jsonR)
            }
            
            print("\n----------")
        
        }
        
        var url: String = ""
        
        let headers: HTTPHeaders? = {
        
            if let access_token = LoginViewModel.Server_Authorization?.token {

                return ["Authorization" : access_token]
            }
            return ["Content-Type":"application/json"]
        }()
        
        let p: Parameters = {
           let p = parameters ?? Parameters()
        
            url = Server.urlBase + operation.rawValue.url

            print(url)
            
            return p
        }()
        
        var urlEncoding: ParameterEncoding!
            
        urlEncoding = operation.rawValue.encoding
        
        dataRequest = alamofireManager.request(url.isEmpty ? (Server.urlBase + operation.rawValue.url): url, method: operation.rawValue.method, parameters: p, encoding: urlEncoding, headers: headers).validate().responseJSON { (response) in
            
            debugRequest(method: operation.rawValue.method.rawValue, url: url.isEmpty ? (Server.urlBase + operation.rawValue.url): url, jsonS: p.prettyPrint(), error: response.error?.localizedDescription, jsonR: response.response?.debugDescription ?? "")// result.debugDescription)
            
            if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                if let data = response.data, !data.isEmpty {
                    do {

                        if operation == .signin || operation == .signup {

                            LoginViewModel.Server_Authorization = try JSONDecoder().decode(LoginModel.self, from: data)
                        }
                        
                        completion?(try JSONDecoder().decode(type, from: data))
                        
                    } catch let e {
                        
                        completion?(e)
                    }
                }
            } else {
                
                print(String(data: response.data ?? Data(), encoding: .utf8) ?? "")
                
                if let server_response = try? JSONDecoder().decode(Server_Response.self, from: response.data ?? Data()) {
                    completion?(server_response)
                } else {
                    completion?(response.error ?? "cant_connect_to_the_server".localized())
                }
            }
        }
    }
 }
