//
//  File.swift
//  
//
//  Created by JerryLai on 2023/10/16.
//

import SwiftUI
import JKit

extension View {
    public func animate(duration: CGFloat, _ execute: @escaping () -> Void, completion: JVoidBlock? = nil) async {
        await withCheckedContinuation { continuation in
            withAnimation(.linear(duration: duration)) {
                execute()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                continuation.resume()
                completion?()
            }
        }
    }
}
