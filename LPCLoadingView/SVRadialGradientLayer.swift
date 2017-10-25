//
//  SVRadialGradientLayer.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 25/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit

class SVRadialGradientLayer: CALayer {
    
    // MARK: Properties
    
    var gradientCenter = CGPoint.zero
    
    // MARK: Override Methods
    
    override func draw(in context: CGContext) {
        let locationsCount: size_t = 2
        let locations: [CGFloat] = [0.0, 1.0]
        let colors: [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75]
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        if let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: locations, count: locationsCount) {
            let radius = CGFloat(min(bounds.size.width, bounds.size.height))
            context.drawRadialGradient(gradient, startCenter: self.gradientCenter, startRadius: 0, endCenter: self.gradientCenter, endRadius: radius, options: .drawsAfterEndLocation)
        }
    }
}
