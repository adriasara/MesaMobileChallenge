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
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestFeed()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
    
    // MARK: - Update News in 30 seconds
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(doRequisitions), userInfo: nil, repeats: true)
    }
    
    @objc func doRequisitions() {
        
        requestFeed()
    }
    
    func stopTimer() {
        
        timer.invalidate()
        timer = Timer()
    }
    
    func requestFeed() {
        
        FeedViewModel.BookmarksUD = nil
        
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
                    
                    if FeedViewModel.BookmarksUD == nil {
                        FeedViewModel.BookmarksUD = model
                    }
                    self.feedView.setModel(model)
                }
            }
        })
    }
}
