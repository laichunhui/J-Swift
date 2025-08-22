//
//  BottomSafeAreaInset+View.swift
//  Anime Now!
//
//  Created by ErrorErrorError on 10/19/22.
//  From https://github.com/FiveStarsBlog/CodeSamples/blob/main/SafeAreaInset/content.swift

import SwiftUI

extension View {
    func readHeight(onChange: @Sendable @escaping (CGFloat) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Spacer()
          .preference(
            key: HeightPreferenceKey.self,
            value: geometryProxy.size.height
          )
      }
    )
    .onPreferenceChange(HeightPreferenceKey.self, perform: onChange)
  }
}

private struct HeightPreferenceKey: @preconcurrency PreferenceKey {
    @MainActor static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

