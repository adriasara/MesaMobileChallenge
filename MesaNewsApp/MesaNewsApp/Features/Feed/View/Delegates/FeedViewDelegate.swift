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

        feedCarousselView.setModel(modelData[index])
        
        return feedCarousselView
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
