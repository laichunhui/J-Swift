//
//  Chat.swift
//  JO
//
//  Created by jee on 2025/8/21.
//

import Foundation
import JKit
import ComposableArchitecture

@Reducer
struct Chat {
    @ObservableState
    struct State: Equatable {
        var isLoading = false
    }
    
    enum Action: BindableAction {
        case onAppear
        case test
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.network) var network
    
    private enum CancelID { case load }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .test:
                Logger.debug("debug")
                Logger.info("info message\(FileUtils.sysLibCachesPath())")
                Logger.error("error message")
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}
