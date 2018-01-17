//
//  UIPullToRefreshTableView.swift
//  LPCLoadingView
//
//  Created by Alaeddine Ouertani on 30/10/2017.
//  Copyright © 2017 Lakooz. All rights reserved.
//

import UIKit

public protocol UIPullToRefreshDelegate: class {
    func onRefresh()
}

public class UIPullToRefreshTableView: UITableView, UITableViewDelegate {
    
    // MARK: Properties
    
    public weak var delegatePullToRefresh: UIPullToRefreshDelegate?
    
    var lpcRefreshControl: UIRefreshControl?
    
    var customView: LoadingView?
    
    private let customViewHeight = CGFloat(20)
    
    private let customViewWidth = CGFloat(55)
    
    private var layoutWasSubviewed = false
    
    private var isRefreshing = false
    
    // MARK: Overrides
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        configUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if layoutWasSubviewed == false {
            layoutWasSubviewed = true
            configUI()
        }
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        lpcRefreshControl = UIRefreshControl()
        lpcRefreshControl!.backgroundColor = UIColor.clear
        lpcRefreshControl!.tintColor = UIColor.clear
        if #available(iOS 10.0, *) {
            refreshControl = lpcRefreshControl!
        } else {
            addSubview(lpcRefreshControl!)
        }
        let frame = CGRect(x: (self.frame.size.width - customViewWidth) / 2, y: -customViewHeight / 2, width: customViewWidth, height: customViewHeight)
        customView = LoadingView(frame: frame)
        lpcRefreshControl!.addSubview(customView!)
    }
    
    private func refresh() {
        if let lpcRefreshControl = self.lpcRefreshControl, let customView = self.customView,  lpcRefreshControl.isRefreshing, !customView.isAnimating, !isRefreshing {
            isRefreshing = true
            customView.isAnimating = true
            lpcRefreshControl.beginRefreshing()
            delegatePullToRefresh?.onRefresh()
        }
    }
    
    // MARK: Public Methods
    
    public func endRefreshing() {
        if let lpcRefreshControl = self.lpcRefreshControl, let customView = self.customView, customView.isAnimating, isRefreshing {
            isRefreshing = false
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(__int64_t(1)), execute: {
                lpcRefreshControl.endRefreshing()
                customView.isAnimating = false
            })
        }
    }
    
    public func scrollViewDidEndDecelerating(_: UIScrollView) {
        refresh()
    }
    
    public func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {
        refresh()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        customView?.frame = CGRect(x: (frame.size.width - customViewWidth) / 2, y: (-contentOffset - customViewHeight) / 2, width: customViewWidth, height: customViewHeight)
    }
}


