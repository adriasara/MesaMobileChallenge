//
//  FeedViewDelegate.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit

extension FeedView: iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        if carousel.tag == 1 {
            if modelData.count > 0 {
                return modelData.count
            }
        } else if carousel.tag == 2 {
            return FeedViewModel.BookmarksUD?.count ?? 0
        }
        return 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {

        if carousel.tag == 1 {
            
            let viewFeed = CarousselView(frame: CGRect(x: 0, y: 0, width: frame.width * 0.85, height: 200))
            viewFeed.delegate = self
            viewFeed.currentIndex = index
            viewFeed.setFavouriteButtonHidden(false)
            viewFeed.setModel(modelData[index])
            
            return viewFeed
        } else if carousel.tag == 2 {
            let viewBookmark = CarousselView(frame: CGRect(x: 0, y: 0, width: frame.width * 0.85, height: 200))
            viewBookmark.delegate = self
            viewBookmark.setFavouriteButtonHidden(true)
            viewBookmark.setModel(FeedViewModel.BookmarksUD?[index] ?? DataModel())
            return viewBookmark
        }
        return UIView()
    }
}

extension FeedView: iCarouselDelegate {
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {

        if option == .spacing {
            return value * 1.1
        }
        return value
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        if carousel.tag == 1 {
            currentIndex = carousel.currentItemIndex
            print(carousel.currentItemIndex)
        } else if carousel.tag == 2 {
            print(carousel.currentItemIndex)
        }
    }
}
