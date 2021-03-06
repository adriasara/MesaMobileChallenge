//
//  StyleKit.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 23/03/21.
//

import UIKit

struct StyleKit {

    public struct fonts {
        
        static let smallText = UIFont(name: "Arial-Regular", size: 10.0)
        static let normalText = UIFont(name: "Arial-Regular", size: 12.0)
        static let titleText = UIFont(name: "Arial-Regular", size: 14.0)
        
        static let boldText = UIFont(name: "Arial-BoldMT", size: 12.0)
        static let boldMediumText = UIFont(name: "Arial-BoldMT", size: 16.0)
        static let boldLargeText = UIFont(name: "Arial-BoldMT", size: 20.0)
    }
    
    public struct colors {
        
        static let white = UIColor.white
        static let black = UIColor.black
        static let lightGray = UIColor.lightGray
        static let darkGray = UIColor.darkGray
    }
    
    public struct borders {
        
        static let buttons = CGFloat(8.0)
        static let textFields = CGFloat(8.0)
        static let views = CGFloat(24.0)
    }
}
