//
//  FeedViewModel.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit

final class FeedViewModel: NSObject {
    
    private let model: FeedModel
    private var viewController: UIViewController
    
    init(model: FeedModel = .init(), viewController: UIViewController) {
        self.model = model
        self.viewController = viewController
    }
    
    func requestFeed(completion: ((_ object: Any) -> Void)?) {
        
        self.service(controller: viewController, operation: .feed, parameters: ["current_page" : "", "per_page" : "", "published_at" : ""], type: FeedModel.self) { (response) in
            
            if let error = response as? NSError {
                completion?(error)

            } else if let server_response = response as? Server_Response {
                completion?(server_response)
                
            } else {
                
                completion?(response)
            }
        }
    }
    
    static var BookmarksUD: [DataModel]? {
        get {

            guard let data = UserDefaults.standard.object(forKey: "BookmarksUD") as? Data else {
                return nil
            }

            return try? JSONDecoder().decode([DataModel].self, from: data)

        } set {

            if let data = newValue  {
                UserDefaults.standard.set(try? JSONEncoder().encode(data), forKey: "BookmarksUD")

            } else {

                UserDefaults.standard.set(nil, forKey: "BookmarksUD")
            }
        }
    }
}
