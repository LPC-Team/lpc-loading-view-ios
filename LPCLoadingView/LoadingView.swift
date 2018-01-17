//
//  LoadingView.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 25/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit

public final class LoadingView: UIView {
    
    // MARK: Static Properties
    
    private static let kShowHideAnimateDuration = 0.2
    
    // MARK: Properties
    
    public var isAnimating: Bool = false {
        didSet {
            if self.isAnimating {
                self.doAnimateCycle(withRects: [self.rect1, self.rect2, self.rect3])
            } else {
                self.endAnimation = true
            }
        }
    }
    
    private var hudColor: UIColor?
    private var hudRects = [AnyHashable]()
    private var endAnimation: Bool = false
    
    private var rect1: UIView!
    private var rect2: UIView!
    private var rect3: UIView!
    
    // MARK: Override Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configUI()
        isUserInteractionEnabled = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        backgroundColor = UIColor.clear
        self.rect1 = drawRect(atPosition: CGPoint(x: 0, y: 0))
        self.rect2 = drawRect(atPosition: CGPoint(x: 20, y: 0))
        self.rect3 = drawRect(atPosition: CGPoint(x: 40, y: 0))
        addSubview(self.rect1)
        addSubview(self.rect2)
        addSubview(self.rect3)
        self.setHudColor()
    }
    
    private func doAnimateCycle(withRects rects: [UIView]) {
        if !self.endAnimation {
            weak var wSelf: LoadingView? = self
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(0.25 * 0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
                wSelf?.animateRect(rects[0], withDuration: 0.25)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(0.25 * 0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
                    wSelf?.animateRect(rects[1], withDuration: 0.2)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(0.2 * 0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
                        wSelf?.animateRect(rects[2], withDuration: 0.15)
                    })
                })
            })
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(0.6 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {() -> Void in
                wSelf?.doAnimateCycle(withRects: rects)
            })
        } else {
            self.endAnimation = false
        }
    }
    
    private func animateRect(_ rect: UIView, withDuration duration: TimeInterval) {
        rect.autoresizingMask = .flexibleHeight
        UIView.animate(withDuration: duration, animations: {() -> Void in
            rect.alpha = 1
            rect.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: duration, animations: {() -> Void in
                rect.alpha = 0.5
                rect.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: {(_ finished: Bool) -> Void in
            })
        })
    }
    
    private func drawRect(atPosition positionPoint: CGPoint) -> UIView {
        let rect = UIView()
        let rectFrame = CGRect(x:positionPoint.x , y: 0, width: 15, height: 15)
        rect.frame = rectFrame
        rect.backgroundColor = UIColor.red
        rect.alpha = 0.5
        rect.layer.cornerRadius = rectFrame.size.width / 2
        self.hudRects.append(rect)
        return rect
    }
    
    private func setHudColor() {
        let hudColors = [UIColor.primary(), UIColor.tertiary(), UIColor.secondary()]
        for i in 0..<self.hudRects.count {
            let rect = self.hudRects[i] as? UIView
            rect?.backgroundColor = hudColors[i]
        }
    }
    
    // MARK: Internal Methods
    
    final func hide() {
        UIView.animate(withDuration: LoadingView.kShowHideAnimateDuration, animations: {() -> Void in
            self.alpha = 0
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
    
    final func show(animated: Bool) {
        if animated {
            UIView.animate(withDuration: LoadingView.kShowHideAnimateDuration, animations: {() -> Void in
                self.alpha = 1
            })
        }
        else {
            alpha = 1
        }
    }
}
