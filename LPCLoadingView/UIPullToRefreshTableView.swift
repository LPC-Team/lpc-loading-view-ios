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
    
    weak public var delegatePullToRefresh: UIPullToRefreshDelegate?
    
    var lpcRefreshControl: UIRefreshControl!
    
    var customView: LoadingView!
    
    // MARK: Overrides
    
    override public init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.configUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configUI()
    }
    
    // MARK: Private Methods
    
    private func configUI() {
        delegate = self
        
        self.lpcRefreshControl = UIRefreshControl()
        self.lpcRefreshControl.backgroundColor = UIColor.clear
        self.lpcRefreshControl.tintColor = UIColor.clear
        addSubview(lpcRefreshControl)
        let frame = CGRect(x: (self.frame.size.width - 55) / 2, y: (self.lpcRefreshControl.frame.size.height - 20) / 2, width: 55, height: 20)
        self.customView = LoadingView(frame: frame)
        self.lpcRefreshControl.addSubview(customView)
    }
    
    // MARK: Public Methods
    
    public func endRefreshing() {
        if lpcRefreshControl.isRefreshing {
            self.lpcRefreshControl.endRefreshing()
            self.customView.isAnimating = false
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if lpcRefreshControl.isRefreshing {
            self.customView.isAnimating = true
            self.delegatePullToRefresh?.onRefresh()
        }
    }
}
