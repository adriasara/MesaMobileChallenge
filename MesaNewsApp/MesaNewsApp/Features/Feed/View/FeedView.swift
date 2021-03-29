//
//  FeedView.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit
import Stevia

final class FeedView: UIView {
    
    var modelData = [DataModel]()
    var currentIndex: Int = 0
    
    private lazy var titleNews: UILabel = {
        let titleNews = UILabel(frame: .zero)
        titleNews.font = StyleKit.fonts.boldMediumText
        titleNews.textColor = StyleKit.colors.black
        titleNews.textAlignment = .left
        titleNews.numberOfLines = 2
        titleNews.text = "news".localized()
        return titleNews
    }()
    
    private lazy var carousselFeedView: iCarousel = {
        let carousselFeedView = iCarousel(frame: .zero)
        carousselFeedView.type = .coverFlow
        carousselFeedView.isScrollEnabled = true
        carousselFeedView.tag = 1
        carousselFeedView.contentMode = .scaleAspectFill
        return carousselFeedView
    }()
    
    private lazy var carousselBookmarkView: iCarousel = {
        let carousselBookmarkView = iCarousel(frame: .zero)
        carousselBookmarkView.type = .coverFlow
        carousselBookmarkView.isScrollEnabled = true
        carousselBookmarkView.tag = 2
        carousselBookmarkView.contentMode = .scaleAspectFill
        return carousselBookmarkView
    }()
    
    private lazy var titleBookmarks: UILabel = {
        let titleBookmarks = UILabel(frame: .zero)
        titleBookmarks.font = StyleKit.fonts.boldMediumText
        titleBookmarks.textColor = StyleKit.colors.black
        titleBookmarks.textAlignment = .left
        titleBookmarks.numberOfLines = 2
        titleBookmarks.text = "bookmarks".localized()
        return titleBookmarks
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
        carousselFeedView.delegate = self
        carousselFeedView.dataSource = self
        carousselBookmarkView.delegate = self
        carousselBookmarkView.dataSource = self
        carousselFeedView.reloadData()
        carousselBookmarkView.reloadData()
        subviews()
        layout()
    }
    
    private func subviews() {
        
        sv([titleNews, carousselFeedView, titleBookmarks, carousselBookmarkView])
    }
    
    private func layout() {
                
        titleNews.centerHorizontally().top(10%).left(15).right(10)
        
        carousselFeedView.width(85%).height(200).centerHorizontally().Top == titleNews.Bottom + 15
        
        titleBookmarks.left(15).right(10).Top == carousselFeedView.Bottom + 15
        
        carousselBookmarkView.width(85%).height(200).centerHorizontally().Top == titleBookmarks.Bottom + 15
    }
    
    func setModel(_ model: [DataModel]) {
        modelData = model
        carousselFeedView.reloadData()
    }
}

extension FeedView: CarousselViewDelegate {
    
    func bookmarksAction(button: UIButton) {
            
        if button.imageView?.image == #imageLiteral(resourceName: "heart") {
            button.setImage(#imageLiteral(resourceName: "emptyHeart"), for: .normal)
            FeedViewModel.BookmarksUD?.removeAll(where: { $0.title == modelData[currentIndex].title})
        } else if button.imageView?.image == #imageLiteral(resourceName: "emptyHeart") {
            button.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            FeedViewModel.BookmarksUD?.append(modelData[currentIndex])
        }
        carousselBookmarkView.reloadData()
    }
}
