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

protocol CarousselViewDelegate: NSObjectProtocol {
    func bookmarksAction(button: UIButton)
}

final class CarousselView: UIView {
    
    weak var delegate: CarousselViewDelegate?
    
    var currentIndex: Int = 0
    
    private lazy var title: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = StyleKit.fonts.boldText
        title.textColor = StyleKit.colors.black
        title.textAlignment = .center
        title.numberOfLines = 2
        return title
    }()
    
    private lazy var imageURL: UIImageView = {
        let imageURL = UIImageView(frame: .zero)
        imageURL.contentMode = .scaleToFill
        return imageURL
    }()
    
    private lazy var descriptionNews: UILabel = {
        let descriptionNews = UILabel(frame: .zero)
        descriptionNews.font = StyleKit.fonts.smallText
        descriptionNews.textColor = StyleKit.colors.black
        descriptionNews.textAlignment = .center
        descriptionNews.numberOfLines = 2
        return descriptionNews
    }()
    
    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton(frame: .zero)
        favouriteButton.backgroundColor = .clear
        favouriteButton.titleLabel?.font = StyleKit.fonts.normalText
        favouriteButton.setTitleColor(.blue, for: .normal)
        favouriteButton.setImage(#imageLiteral(resourceName: "emptyHeart"), for: .normal)
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
        backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        layer.cornerRadius = StyleKit.borders.views
        layer.shadowRadius = 3.0
        layer.shadowColor = #colorLiteral(red: 0.7745774388, green: 0.7944802642, blue: 0.7939844728, alpha: 1)
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 3)
        
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
        
        descriptionNews.left(10).width(75%).Top == imageURL.Bottom + 15

        favouriteButton.width(20).heightEqualsWidth().right(15).Top == imageURL.Bottom + 20
    }
    
    private func addActions() {
        favouriteButton.addTarget(self, action: #selector(bookmarkAction), for: .touchUpInside)
    }
    
    @objc private func bookmarkAction() {
        delegate?.bookmarksAction(button: favouriteButton)
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
        
        if let highlight = model.highlight {
            if highlight {
                favouriteButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            } else {
                favouriteButton.setImage(#imageLiteral(resourceName: "emptyHeart"), for: .normal)
            }
        }
    }
    
    func setFavouriteButtonHidden(_ isHidden: Bool) {
        favouriteButton.isHidden = isHidden
    }
    
    func getFavButton() -> UIButton {
        return favouriteButton
    }
}
