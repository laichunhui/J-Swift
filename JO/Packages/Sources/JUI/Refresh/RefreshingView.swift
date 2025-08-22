//
//  File.swift
//  Packages
//
//  Created by work on 16/12/24.
//

import Foundation
import SwiftUI
import MJRefresh
import JResources

public struct SimplePullToRefreshView: View {
    let progress: CGFloat
    
    public init(progress: CGFloat) {
        self.progress = progress
    }
    public var body: some View {
        Text("Pull to refresh")
    }
}

public struct FooterLoadingView: View {
    public init() {}
    public var body: some View {
        ActivityIndicator()
    }
}

public struct NoMoreTipView: View {
    public init() {}
    public var body: some View {
        Text("No more data !")
            .foregroundColor(.secondary)
    }
}

public struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style = .medium
    
    public init() {}
    
    public func makeUIView(context: Context) -> UIActivityIndicatorView  {
        return UIActivityIndicatorView(style: style)
    }
    
    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}

public class TGRefreshHeader: MJRefreshNormalHeader {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        self.isAutomaticallyChangeAlpha = true
        self.lastUpdatedTimeLabel?.isHidden = true
        self.labelLeftInset = 0
        let text = ""
        self.stateLabel?.font = TGFont.normal(size: .t2, weight: .medium).uiFont
        self.setTitle(text, for: .idle)
        self.setTitle(text, for: .refreshing)
        self.setTitle(text, for: .pulling)
    }
}

public class TGRefreshFooter: MJRefreshAutoNormalFooter {
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        self.isAutomaticallyChangeAlpha = true
        self.labelLeftInset = 0
        let text = ""
        self.stateLabel?.font = TGFont.normal(size: .t2, weight: .medium).uiFont
        self.setTitle(text, for: .idle)
        self.setTitle(text, for: .refreshing)
        self.setTitle(text, for: .pulling)
        self.setTitle(text, for: .noMoreData)
    }
}
