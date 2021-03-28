//
//  FeedView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit
import Stevia

final class FeedView: UIView {
    
    private lazy var carousselView: iCarousel = {
        let carousselView = iCarousel(frame: .zero)
        carousselView.type = .coverFlow
        carousselView.isScrollEnabled = true
        carousselView.contentMode = .scaleAspectFill
        return carousselView
    }()
    
    lazy var feedCarousselView: CarousselView = {
        let feedCarousselView = CarousselView(frame: CGRect(x: 0, y: 0, width: frame.width * 0.85, height: frame.height * 0.85))
        feedCarousselView.backgroundColor = .white
        feedCarousselView.layer.cornerRadius = StyleKit.borders.views
        feedCarousselView.layer.shadowRadius = 3.0
        feedCarousselView.layer.shadowColor = #colorLiteral(red: 0.7745774388, green: 0.7944802642, blue: 0.7939844728, alpha: 1)
        feedCarousselView.layer.shadowOpacity = 1.0
        feedCarousselView.layer.shadowOffset = CGSize(width: 0, height: 3)
        return feedCarousselView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .yellow
        carousselView.delegate = self
        carousselView.dataSource = self
        subviews()
        layout()
    }
    
    private func subviews() {
        
        sv([carousselView])
    }
    
    private func layout() {
        
        carousselView.width(85%).height(85%).centerHorizontally().top(30)
    }
    
    var modelData = [DataModel]()
    
    func setModel(_ model: [DataModel]) {
        modelData = model
        carousselView.reloadData()
    }
}
