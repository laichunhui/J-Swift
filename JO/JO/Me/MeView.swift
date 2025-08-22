//
//  MeView.swift
//  JO
//
//  Created by jee on 2025/8/21.
//

import SwiftUI
import ComposableArchitecture

struct MeView: View {
    let store: StoreOf<Me>
    
    var body: some View {
        WithPerceptionTracking {}
    }
}
