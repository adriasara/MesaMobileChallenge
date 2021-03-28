//
//  FeedVC.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit

final class FeedVC: UIViewController {
    
    let feedView: FeedView = FeedView(frame: .zero)
    var viewModelFeed: FeedViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestFeed()
        
        title = "Feed"
    }
    
    func requestFeed() {
        
        viewModelFeed = FeedViewModel(model: .init(), viewController: self)
        
        viewModelFeed?.requestFeed(completion: { (response) in
            
            if let e = response as? NSError {
                self.setSnackBarText(e.localizedDescription)
            } else if let server_response = response as? Server_Response {
                if let mssg = server_response.mssg {
                    self.setSnackBarText(mssg)
                }
            } else {
                if let jResult = response as? FeedModel, let data = jResult.data {
                    
                    self.view.sv([self.feedView])
                    self.feedView.fillContainer()
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MM, yyyy"
                    
                    let model = data.sorted(by: { dateFormatter.date(from:$0.published_at ?? "")?.compare(dateFormatter.date(from:$1.published_at ?? "") ?? Date()) == .orderedDescending })
                    
                    self.feedView.setModel(model)
                }
            }
        })
    }
}
