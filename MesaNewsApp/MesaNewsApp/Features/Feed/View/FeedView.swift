//
//  FeedView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit
import Stevia

final class FeedView: UIView {
    
    private lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = StyleKit.fonts.boldLargeText
        title.textColor = StyleKit.colors.black
        title.textAlignment = .center
        title.numberOfLines = 2
        title.text = "Feed"
        return title
    }()
    
    private lazy var carousselView: iCarousel = {
        let carousselView = iCarousel(frame: .zero)
        carousselView.type = .coverFlow
        carousselView.isScrollEnabled = true
        carousselView.contentMode = .scaleAspectFill
        return carousselView
    }()
    
    private lazy var feedCarousselView: CarousselView = {
        let feedCarousselView = CarousselView(frame: .zero)
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
        backgroundColor = .lightGray
        carousselView.delegate = self
        carousselView.dataSource = self
        carousselView.reloadData()
        subviews()
        layout()
    }
    
    private func subviews() {
        
        sv([title, carousselView])
    }
    
    private func layout() {
        
        title.centerHorizontally().top(8%).left(10).right(10)
        
        carousselView.width(85%).height(50%).centerHorizontally().Top == title.Bottom + 20
    }
    
    var modelData = [DataModel]()
    
    func setModel(_ model: [DataModel]) {
        modelData = model
        carousselView.reloadData()
    }
}
