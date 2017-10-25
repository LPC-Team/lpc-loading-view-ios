//
//  LoadingView.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 25/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: Static Properties
    
    static let kShowHideAnimateDuration = 0.2
    
    // MARK: Properties
    
    private var hudColor: UIColor?
    private var hudRects = [AnyHashable]()
    
    // MARK: Override Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        isUserInteractionEnabled = false
        alpha = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal Methods
    
    func configUI() {
        backgroundColor = UIColor.clear
        let rect1 = drawRect(atPosition: CGPoint(x: 0, y: 0))
        let rect2 = drawRect(atPosition: CGPoint(x: 20, y: 0))
        let rect3 = drawRect(atPosition: CGPoint(x: 40, y: 0))
        addSubview(rect1)
        addSubview(rect2)
        addSubview(rect3)
        doAnimateCycle(withRects: [rect1, rect2, rect3])
        setHudColor()
    }
    
    func doAnimateCycle(withRects rects: [UIView]) {
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
    }
    
    func animateRect(_ rect: UIView, withDuration duration: TimeInterval) {
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
    
    func drawRect(atPosition positionPoint: CGPoint) -> UIView {
        let rect = UIView()
        let rectFrame = CGRect(x:positionPoint.x , y: 0, width: 15, height: 15)
        rect.frame = rectFrame
        rect.backgroundColor = UIColor.red
        rect.alpha = 0.5
        rect.layer.cornerRadius = rectFrame.size.width / 2
        hudRects.append(rect)
        return rect
    }
    
    func setHudColor() {
        let hudColors = [UIColor.primary(), UIColor.tertiary(), UIColor.secondary()]
        for i in 0..<hudRects.count {
            let rect = hudRects[i] as? UIView
            rect?.backgroundColor = hudColors[i]
        }
    }
    
    func hide() {
        UIView.animate(withDuration: LoadingView.kShowHideAnimateDuration, animations: {() -> Void in
            self.alpha = 0
        }, completion: {(_ finished: Bool) -> Void in
        })
    }
    
    func show(animated: Bool) {
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
