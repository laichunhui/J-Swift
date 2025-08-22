//
//  JOApp.swift
//  JO
//
//  Created by jee on 2025/8/7.
//

import SwiftUI
import ComposableArchitecture
import JKit

@main
struct JApp: App {
    @MainActor
    static let appStore: StoreOf<AppReducer> = Store(initialState: AppReducer.State()) {
        AppReducer()
    }
    // 记录启动时间
    private let startTime = Date()
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            AppView(store: JApp.appStore)
                .onAppear {
                       // 计算启动时间
                       let endTime = Date()
                       let elapsedTime = endTime.timeIntervalSince(startTime)
                        Logger.info("应用启动时间: \(elapsedTime) 秒")
                   }
        }
        .onChange(of: scenePhase, perform: { phase in
            switch phase {
            case .active:
                Logger.info("应用启动了")
            case .inactive:
                Logger.info("应用休眠了")
            case .background:
                Logger.info("应用在后台展示")
                JApp.appStore.send(.appDelegate(.appDidEnterBackground))
            @unknown default:
                Logger.info("default")
            }
        })
    }
}
