//
//  CarousselView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit
import Stevia
import Alamofire
import AlamofireImage

final class CarousselView: UIView {
    
    private lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = StyleKit.fonts.mediumText
        title.textColor = StyleKit.colors.black
        title.textAlignment = .center
        title.numberOfLines = 2
        title.text = "oi manaus"
        return title
    }()
    
    private lazy var imageURL: UIImageView = {
        let imageURL = UIImageView(frame: .zero)
        return imageURL
    }()
    
    private lazy var descriptionNews: UILabel = {
        let descriptionNews = UILabel(frame: .zero)
        descriptionNews.font = StyleKit.fonts.normalText
        descriptionNews.textColor = StyleKit.colors.black
        descriptionNews.textAlignment = .center
        descriptionNews.numberOfLines = 2
        descriptionNews.text = "vain"
        return descriptionNews
    }()
    
    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton(frame: .zero)
        favouriteButton.backgroundColor = .clear
        favouriteButton.titleLabel?.font = StyleKit.fonts.normalText
        favouriteButton.setTitleColor(.blue, for: .normal)
        favouriteButton.setTitle("favor".localized(), for: .normal)
        return favouriteButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .green
        
        subviews()
        layout()
        addActions()
    }
    
    private func subviews() {
        
        sv([title,imageURL, descriptionNews, favouriteButton])
    }
    
    private func layout() {
        
        title.centerHorizontally().top(20).left(10).right(10)
        
        imageURL.left(20).right(20).height(30%).Top == title.Bottom + 20
        
        descriptionNews.left(10).right(10).Top == imageURL.Bottom + 20

        favouriteButton.right(10).Top == descriptionNews.Bottom + 15
    }
    
    private func addActions() {
        
    }
    
    func setModel(_ model: DataModel) {
        title.text = model.title
        if let url = model.image_url {
            if let urlConvertible = URL(string: url) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: urlConvertible) {
                        DispatchQueue.main.async {
                            self.imageURL.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        descriptionNews.text = model.descriptionHighlights
    }
}
