//
//  AppReducer.swift
//  Hazar
//
//  Created by work on 5/11/24.
//

import SwiftUI
import ComposableArchitecture
import JKit
import JNetwork
import JResources

@Reducer
struct AppReducer : Sendable{
    enum CancelID {
        case loginState
        case loginSession
        case newMessage
        case updateUser
        case messageUnread
        case lang
        case timer
        case imExpired
        case totalUnreadMessageCount
    }
    @ObservableState
    struct State: Equatable {
        var isLogin = true
        var isRegisterInfo = true
        var route = Route.home
        public var allCases: [Route] = [.home, .chat, .me]
        var home = Home.State()
//        var login = LoginReducer.State()
        var me = Me.State()
        var chat = Chat.State()
//        var roomFloating = RoomFloatingReducer.State()
        var description = ""
        var isComplete = false
        // 版本更新是否已检测
        var isCheckedVersion = false
        // 在tab首页
        var inMainView = true
        /// 未读消息数量
        var unreadMessageCount = 0
        var unreadUnmutedCount = 0

        var layoutDirection: LayoutDirection = .leftToRight
   
        init() {

        }
    }
    
    enum Action: BindableAction {
        case onAppear
        case appDelegate(AppDelegateReducer.Action)
        case open(url: URL)
        case authorizationStateReady
        case home(Home.Action)
//        case login(LoginReducer.Action)
        case me(Me.Action)
        case chat(Chat.Action)
//        case upDateUser(HaUser)
//        case roomFloating(RoomFloatingReducer.Action)
        case binding(BindingAction<State>)
        case showOnMain(Bool)
        case showFullFeature
        case langDidChanged(LocaleType)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Scope(state: \.me.userSettings, action: \.appDelegate) {
            AppDelegateReducer()
        }
        Scope(state: \.home, action: \.home) {
            Home()
        }
        Scope(state: \.me, action: \.me) {
            Me()
        }
        Scope(state: \.chat, action: \.chat) {
            Chat()
        }
        Reduce(self.core)
    }
    @Dependency(\.network) var network

}

extension AppReducer {
    private func initialize() async {

    }
    
    private func startObservations(_ state: inout State) -> Effect<Action> {
        var effects = [Effect<Action>]()
        effects.append(
            .run { send in
                await initialize()
            }
        )
//        effects.append(
//            .run { send in
//                for await status in network.networkStatus.stream {
//                    if case NetworkReachabilityManager.NetworkReachabilityStatus.reachable = status {
////                        await send(.fetchConfig)
//                    }
//                }
//            }
//        )
//        effects.append(
//            .run { send in
//                for await lang in LocaleClient.shared.$lang.stream {
//                    Logger.print("语言切换: \(lang)")
//                    await send(.langDidChanged(lang))
////                    await send(.game(.changeLangauge))
////                    await send(.home(.changeLangauge))
////                    await send(.binding(.set(\.$lang, lang)))
//                }
//            }
//            .cancellable(id: CancelID.lang)
//        )
        
        return .merge(effects)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            break
        case .appDelegate(.appDidFinishLaunching):
            return startObservations(&state)
        case .authorizationStateReady:
            state.isLogin = true
        case let .langDidChanged(lang):
            state.layoutDirection = lang == .ar ? .rightToLeft : .leftToRight
        default:
            break
        }
        return .none
    }
}
