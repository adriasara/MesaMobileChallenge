//
//  LoadBarView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit
import MaterialComponents
import Stevia

final class LoadBarView: UIView {
    
    private lazy var activityIndicator: MDCActivityIndicator = {
        let activityIndicator = MDCActivityIndicator(frame: .zero)
        activityIndicator.cycleColors = [UIColor.white]
        activityIndicator.radius = 20.0
        activityIndicator.strokeWidth = 4.0
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private lazy var waitLabel: UILabel = {
        let waitLabel = UILabel(frame: .zero)
        waitLabel.text = "wait".localized()
        waitLabel.font = StyleKit.fonts.normalText
        waitLabel.textColor = StyleKit.colors.white
        waitLabel.textAlignment = .center
        return waitLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        
        subviews()
        layout()
    }
    
    private func subviews() {
        
        sv([activityIndicator, waitLabel])
    }
    
    private func layout() {
        
        activityIndicator.centerHorizontally().centerVertically().height(15).width(15)
        
        waitLabel.left(10).right(10).height(20).Top == activityIndicator.Bottom + 20
    }
}
