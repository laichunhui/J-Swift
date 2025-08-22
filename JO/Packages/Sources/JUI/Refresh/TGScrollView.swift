//
//  File.swift
//  Packages
//
//  Created by work on 16/12/24.
//

import Foundation
import JKit
import MJRefresh
import SwiftUI
import SwiftUIIntrospect

public struct TGRefreshState: Equatable {
    public enum RefreshState: Equatable {
        case idle, refreshing, loadMore, end, resetNomore
    }
    public var state: RefreshState
    public var noMore: Bool

    public init(_ state: RefreshState, noMore: Bool) {
        self.state = state
        self.noMore = noMore
    }
}

extension TGRefreshState: TGBuildable {
    public func state(_ value: TGRefreshState.RefreshState) -> Self {
        mutating(keyPath: \.state, value: value)
    }

    public func noMore(_ value: Bool) -> Self {
        mutating(keyPath: \.noMore, value: value)
    }
}

public struct TGScrollView<Content>: View where Content: View {

    public var content: Content
    public var axes: Axis.Set
    /// The default is `true`.
    public var showsIndicators: Bool

    var enableHeaderRefresh: Bool = false
    var enableFooterRefresh: Bool = false

    @Binding var refreshState: TGRefreshState

    @State var footerRefreshState: MJRefreshState = .idle
    @State var srcView: UIScrollView?

    var isHiddenHeaderLoading: Bool = false
    var isHiddenFooterLoading: Bool = false

    var onOffsetChanged: JGenericBlock<CGPoint>?
    var onContentSizeChange: JGenericBlock<CGSize>?

    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        refreshState: Binding<TGRefreshState> = .constant(
            .init(.idle, noMore: false)),
        @ViewBuilder content: () -> Content
    ) {
        _refreshState = refreshState
        self.content = content()
        self.axes = axes
        self.showsIndicators = showsIndicators
    }

    public var body: some View {

        ScrollView(axes, showsIndicators: showsIndicators) {
            GeometryReader { proxy in
                Color.clear.preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named("ScrollViewOrigin")).origin)
            }
            .frame(width: 0, height: 0)

            VStack(spacing: 0) {
                content
                let h: CGFloat =
                    (footerRefreshState == .noMoreData
                        || footerRefreshState == .refreshing
                        || footerRefreshState == .willRefresh) ? 44 : 0.001
                Rectangle().fill(Color.clear).frame(height: h)
            }
        }
        .onChange(
            of: refreshState,
            perform: { newValue in
                update(state: newValue)
            }
        )
        .coordinateSpace(name: "ScrollViewOrigin")
        .onPreferenceChange(OffsetPreferenceKey.self) { offset in
            DispatchQueue.main.async {
                self.onOffsetChanged?(offset)
            }
        }
        .onDisappear {
            srcView = nil
        }
        .introspect(
            .scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18),
            customize: { scr in
                DispatchQueue.main.async(execute: {
                    srcView = scr
                    if enableHeaderRefresh, scr.mj_header == nil {
                        TGRefreshHeader {
                            refreshState = refreshState.state(.refreshing)
                        }.autoChangeTransparency(true)
                            .link(to: scr)
                    }

                    if enableFooterRefresh, scr.mj_footer == nil {
                        TGRefreshFooter {
                            refreshState = refreshState.state(.loadMore)
                        }.link(to: scr)
                    }
                })
            })
    }

    func update(state: TGRefreshState) {
        guard let scr = srcView else { return }
        switch state.state {
        case .idle:
            break
        case .refreshing:
            let isRefreshing = scr.mj_header?.isRefreshing ?? false
            if !isRefreshing {
                scr.mj_header?.beginRefreshing()
            }
        case .loadMore:
            let isRefreshing = scr.mj_footer?.isRefreshing ?? false
            if !isRefreshing {
                scr.mj_footer?.beginRefreshing()
            }
        case .end:
            endRefresh(noMore: state.noMore)
        //            refreshState = refreshState.state(.idle)
        case .resetNomore:
            scr.mj_footer?.resetNoMoreData()
            refreshState = refreshState.state(.idle).noMore(false)
        }
    }

    func endRefresh(noMore: Bool) {
        guard let scr = srcView else { return }

        let isHeaderRefreshing = scr.mj_header?.isRefreshing ?? false
        let isFooterRefreshing = scr.mj_footer?.isRefreshing ?? false
        if isHeaderRefreshing {
            scr.mj_header?.endRefreshing()
        }

        if isFooterRefreshing {
            if noMore {
                UIView.performWithoutAnimation {
                    scr.mj_footer?.endRefreshingWithNoMoreData()
                }
                DispatchQueue.main.asyncAfter(
                    deadline: .now() + 0.25,
                    execute: {
                        let scrollViewOriginalInset = scr.mj_inset
                        let h =
                            scr.frame.size.height
                            - scrollViewOriginalInset.bottom
                            - scrollViewOriginalInset.top
                        let offset = scr.contentSize.height - h
                        if offset > 0 {
                            //print("[wk] scrollToBottom")
                            //scr.scrollToBottom(animated: true)
                        }
                    })

            } else {
                scr.mj_footer?.endRefreshing()
            }
        }

        if let footer = scr.mj_footer {
            if !noMore, footer.state == .noMoreData {
                footer.resetNoMoreData()
            } else if noMore {
                footer.endRefreshingWithNoMoreData()
            }
        }
    }
}

extension TGScrollView: TGBuildable {
    public func headerRefreshLoading(isHidden: Bool) -> Self {
        mutating(keyPath: \.isHiddenHeaderLoading, value: isHidden)
    }

    public func footerRefreshLoading(isHidden: Bool) -> Self {
        mutating(keyPath: \.isHiddenFooterLoading, value: isHidden)
    }

    public func headerRefreshEnable(_ value: Bool = true) -> Self {
        mutating(keyPath: \.enableHeaderRefresh, value: value)
    }
    public func footerRefreshEnable(_ value: Bool = true) -> Self {
        mutating(keyPath: \.enableFooterRefresh, value: value)
    }

    public func refreshEnable(_ value: Bool = true) -> Self {
        mutating(keyPath: \.enableHeaderRefresh, value: value)
            .mutating(keyPath: \.enableFooterRefresh, value: value)
    }

    public func onOffsetChanged(_ value: JGenericBlock<CGPoint>?) -> Self {
        mutating(keyPath: \.onOffsetChanged, value: value)
    }
    public func onContentSizeChange(_ value: JGenericBlock<CGSize>?) -> Self {
        mutating(keyPath: \.onContentSizeChange, value: value)
    }
}

private struct OffsetPreferenceKey: PreferenceKey {

    nonisolated(unsafe) static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol TGBuildable {}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension TGBuildable {

    /// Mutates a property of the instance
    ///
    /// - Parameter keyPath:    `WritableKeyPath` to the instance property to be modified
    /// - Parameter value:      value to overwrite the  instance property
    public func mutating<T>(keyPath: WritableKeyPath<Self, T>, value: T) -> Self
    {
        var newSelf = self
        newSelf[keyPath: keyPath] = value
        return newSelf
    }

}
