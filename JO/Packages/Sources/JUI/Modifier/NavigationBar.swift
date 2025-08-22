//
//  File.swift
//  
//
//  Created by JerryLai on 2023/7/31.
//

import SwiftUI
import JKit

extension View {
    @ViewBuilder
    public func pureNavigation(color: Color = Color.white, tintColor: Color, title: String = "", topPadding: CGFloat = 0, trailing: some View = Spacer(), backBlock: JVoidBlock? = nil) -> some View {
        self
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
            .modifier(PureNavigationBar(isShow: .constant(true), color: color, tintColor: tintColor, autoBack: backBlock == nil, title: title, topPadding: topPadding, trailing: trailing, backBlock: backBlock))
            .enableSwipeBack(true)
        
    }
}

public struct PureNavigationBar: ViewModifier {
    public var title: String
    public var backBlock: JVoidBlock?
    var trailing: AnyView
    @Binding var isShow: Bool
    var color: Color
    var tintColor: Color
    var autoBack: Bool
    var topPadding: CGFloat
//    @EnvironmentObject private var navigationState: NavigationState 
    @Environment(\.layoutDirection) var direction
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(isShow: Binding<Bool>, color: Color, tintColor: Color, autoBack: Bool, title: String, topPadding: CGFloat, trailing: some View, backBlock: JVoidBlock?) {
        self.title = title
        self.backBlock = backBlock
        self.trailing = trailing.asAnyView()
        self._isShow = isShow
        self.color = color
        self.tintColor = tintColor
        self.autoBack = autoBack
        self.topPadding = topPadding
    }
    
    public func body(content: Content) -> some View {
        ZStack() {
            content
//                .gesture(
//                    DragGesture()
//                        .onEnded { value in
//                            if value.translation.width > 120 { // 右滑手势
//                                presentationMode.wrappedValue.dismiss()
//                            }
//                        }
//                )
            if isShow {
                VStack {
                    HStack(alignment: .center, spacing: 16) {
                        Spacer().overlay(
                            HStack {
                                Button(action: {
                                    self.backBlock?()
//                                    if autoBack {
                                        self.presentationMode.wrappedValue.dismiss()
//                                    }
                                }) {
                                    HStack {
                                        Image(R.image.icon.arrowBack)
                                            .renderingMode(.template)
                                            .foregroundColor(tintColor)
                                            .rotationEffect(.degrees(direction == .leftToRight ? 0 : 180))
                                        Spacer()
                                    }.frame(width: 32, height: 32)
                                }
                                Spacer()
                            }
                        )
                        Text(title)
//                        Text.h3(title)
//                            .fontStyle(size: .h4, weight: .bold, color: tintColor)
                        Spacer().overlay(
                            HStack {
                                Spacer()
                                trailing
                            }
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, topPadding)
                    .frame(height: 44)
                    .background(color)
                    Spacer()
                }
            }
        }
    }
}

public struct JStatusBar: ViewModifier {
    let colorScheme: ColorScheme
    public func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbarColorScheme(colorScheme, for: .navigationBar)
        } else {
            content
                .preferredColorScheme(colorScheme)
        }
    }
}

extension View {
    public func pureStatusBar(colorScheme: ColorScheme) -> some View {
        self.modifier(JStatusBar(colorScheme: colorScheme))
    }
}

struct EnableSwipeBack: ViewModifier {
    let enable: Bool
    func body(content: Content) -> some View {
        content
            .background(UIKitGestureEnabler(enable: enable))
    }
}

struct UIKitGestureEnabler: UIViewControllerRepresentable {
    let enable: Bool
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let navigationController = controller.navigationController {
                navigationController.interactivePopGestureRecognizer?.isEnabled = enable
                navigationController.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

public extension View {
    func enableSwipeBack(_ enable: Bool) -> some View {
        self.modifier(EnableSwipeBack(enable: enable))
    }
}
