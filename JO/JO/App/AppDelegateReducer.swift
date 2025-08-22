//
//  AppDelegateReducer.swift
//  Hazar
//
//  Created by work on 11/11/24.
//

import Foundation
import JNetwork
import ComposableArchitecture
import JUI
import JResources
import JKit

public struct UserSettings: Codable, Equatable {
    public var preferredProvider: String?

    public init(
        preferredProvider: String? = nil
    ) {
        self.preferredProvider = preferredProvider
    }
}

public struct AppDelegateReducer: Reducer {
    public typealias State = UserSettings
    
    public indirect enum Action: Equatable {
        case appDidFinishLaunching
        case appDidEnterBackground
        case appWillTerminate
        case open(url: URL)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
//    @Dependency(\.userDefaultsClient) var userDefaultsClient
}

extension AppDelegateReducer {
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .appDidFinishLaunching:
            configure()
        case .appDidEnterBackground:
            break 
        default:
            break
        }
        
        return .none
    }
    
    private func configure() {
        Logger.configure()
        TGFont.register()
    }
}
