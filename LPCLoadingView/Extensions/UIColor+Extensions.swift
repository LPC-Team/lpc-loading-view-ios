//
//  UIColor+Extensions.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 25/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: UIColor
    
    class func tertiary() -> UIColor {
        return UIColor(red: CGFloat(250.0 / 255), green: CGFloat(199.0 / 255), blue: CGFloat(0.0 / 255), alpha: CGFloat(1.0))
    }
    
    class func primary() -> UIColor {
        return UIColor(red: CGFloat(0.0 / 255), green: CGFloat(160.0 / 255), blue: CGFloat(222.0 / 255), alpha: CGFloat(1.0))
    }
    
    class func secondary() -> UIColor {
        return UIColor(red: CGFloat(1), green: CGFloat(2.0 / 255), blue: CGFloat(137.0 / 255), alpha: CGFloat(1.0))
    }

}

