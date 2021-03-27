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
        
        view.sv([feedView])
        feedView.fillContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestFeed()
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
                if let jResult = response as? FeedModel {
                    jResult.data?.forEach({ (data) in
                        print(data.author)
                    })
                }
            }
        })
    }
}
