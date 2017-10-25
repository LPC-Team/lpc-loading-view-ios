//
//  LoadingHUD.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 25/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit
import Foundation

public class LoadingHUD: UIView {
    
    // MARK: Static Properties
    
    static var sharedView: LoadingHUD?
    
    // MARK: Properties
    
    var loadingView: LoadingView!
    
    // MARK: Static Methods
    
    static func getSharedView() -> LoadingHUD {
        if (sharedView == nil) {
            if let bounds = UIApplication.shared.delegate?.window??.bounds {
                sharedView = LoadingHUD(frame: bounds)
                if let sharedView = sharedView {
                    let frame = CGRect(x: (sharedView.frame.size.width - 55) / 2, y: (sharedView.frame.size.height - 20) / 2, width: 55, height: 20)
                    sharedView.loadingView = LoadingView(frame: frame)
                    sharedView.addSubview(sharedView.loadingView)
                    sharedView.bringSubview(toFront: sharedView.loadingView)
                    let layer = SVRadialGradientLayer()
                    layer.frame = sharedView.bounds
                    var gradientCenter = sharedView.center
                    gradientCenter.y = sharedView.bounds.size.height / 2
                    layer.gradientCenter = gradientCenter
                    sharedView.layer.insertSublayer(layer, at: 0)
                    sharedView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                }
            }
        }
        return sharedView!
    }
    
    // MARK: Public Methods
    
    public class func show() {
        self.addToView()
        self.getSharedView().loadingView?.show(animated: true)
        self.getSharedView().isHidden = false
    }
    
    
    
    public class func dismiss() {
        self.getSharedView().isHidden = true
        self.getSharedView().loadingView?.hide()
    }
    
    // MARK: Internal Methods
    
    class func addToView() {
        if self.getSharedView().superview == nil {
            let frontToBackWindows = UIApplication.shared.windows.reversed()
            for window: UIWindow in frontToBackWindows {
                let windowOnMainScreen: Bool = window.screen == UIScreen.main
                let windowIsVisible: Bool = !window.isHidden && window.alpha > 0
                let windowLevelNormal: Bool = window.windowLevel == UIWindowLevelNormal
                if windowOnMainScreen && windowIsVisible && windowLevelNormal {
                    window.addSubview(self.getSharedView())
                    break
                }
            }
        }
        self.getSharedView().superview?.bringSubview(toFront: self.getSharedView())
    }
}
