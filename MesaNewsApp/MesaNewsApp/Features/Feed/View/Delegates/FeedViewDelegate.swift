//
//  FeedViewDelegate.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit

extension FeedView: iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        if modelData.count > 0 {
            return modelData.count
        }
        return 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {

        let viewFeed = CarousselView(frame: CGRect(x: 0, y: 0, width: frame.width * 0.85, height: frame.height * 0.50))
        viewFeed.setModel(modelData[index])
        
        return viewFeed
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
//        currentIndex = carousel.currentItemIndex
        print(carousel.currentItemIndex)
    }
}
