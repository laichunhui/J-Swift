//
//  Home.swift
//  JO
//
//  Created by jee on 2025/8/20.
//

import Foundation
import ComposableArchitecture
import JNetwork
import JKit

@Reducer
struct Home {
    @ObservableState
    struct State: Equatable {
        var isLoading = false
        var tabData: TabDatas?
    }
    
    enum Action: BindableAction {
        case onAppear
        case test
        case loadData
        case binding(BindingAction<State>)
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.network) var network
    
    private enum CancelID { case load }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .test:
                Logger.debug("debug message")
                Logger.info("info message")
                Logger.error("error message")
                return .none
            case .loadData:
                return .run { send in
                    let res = await network.request(HomeApi.tab(type: "all"), as: TabDatas.self)
                    if case .success(let t) = res {
                        await send(.binding(.set(\.tabData, t)))
                    }
                }
            case .binding(_):
                return .none
            }
        }
    }
    
    
}
