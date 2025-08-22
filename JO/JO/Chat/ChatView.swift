//
//  ChatView.swift
//  JO
//
//  Created by jee on 2025/8/21.
//

import SwiftUI
import ComposableArchitecture

struct ChatView: View {
    var store: StoreOf<Chat>
    
    var body: some View {
        WithPerceptionTracking {}
    }
}
