//
//  UIPullToRefreshTableView.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 30/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit

@objc public protocol UIPullToRefreshDelegate: class {
    func onRefreshStarted()
    @objc optional func onRefreshFinished()
}

public final class UIPullToRefreshTableView: UITableView, UITableViewDelegate {
    
    // MARK: Public Properties
    
    public weak var delegatePullToRefresh: UIPullToRefreshDelegate?
    public var isRefreshing = false
    
    // MARK: Private Properties
    
    private var lpcRefreshControl: UIRefreshControl?
    private var customView: LoadingView?
    private let customViewHeight = CGFloat(20)
    private let customViewWidth = CGFloat(55)
    private var layoutWasSubviewed = false
    
    // MARK: Overrides
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.configUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !self.layoutWasSubviewed {
            self.layoutWasSubviewed = true
            self.configUI()
        }
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        self.lpcRefreshControl = UIRefreshControl()
        self.lpcRefreshControl!.backgroundColor = UIColor.clear
        self.lpcRefreshControl!.tintColor = UIColor.clear
        if #available(iOS 10.0, *) {
            refreshControl = self.lpcRefreshControl!
        } else {
            addSubview(self.lpcRefreshControl!)
        }
        let frame = CGRect(x: (self.frame.size.width - self.customViewWidth) / 2, y: -self.customViewHeight / 2, width: self.customViewWidth, height: self.customViewHeight)
        self.customView = LoadingView(frame: frame)
        self.lpcRefreshControl!.addSubview(self.customView!)
    }
    
    private func refresh() {
        if let lpcRefreshControl = self.lpcRefreshControl, let customView = self.customView,  lpcRefreshControl.isRefreshing, !customView.isAnimating, !self.isRefreshing {
            self.isRefreshing = true
            customView.isAnimating = true
            lpcRefreshControl.beginRefreshing()
            self.delegatePullToRefresh?.onRefreshStarted()
        }
    }
    
    // MARK: Public Methods
    
    public final func endRefreshing() {
        if let lpcRefreshControl = self.lpcRefreshControl, let customView = self.customView, customView.isAnimating, self.isRefreshing {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(1)), execute: {
                lpcRefreshControl.endRefreshing()
                customView.isAnimating = false
                self.isRefreshing = false
                self.delegatePullToRefresh?.onRefreshFinished?()
            })
        }
    }
    
    public final func scrollViewDidEndDecelerating(_: UIScrollView) {
        self.refresh()
    }
    
    public final func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {
        self.refresh()
    }
    
    public final func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        self.customView?.frame = CGRect(x: (frame.size.width - self.customViewWidth) / 2, y: (-contentOffset - self.customViewHeight) / 2, width: self.customViewWidth, height: self.customViewHeight)
    }
}
