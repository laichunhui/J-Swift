//
//  File.swift
//  
//
//  Created by JerryLai on 2023/9/21.
//

import Foundation

public struct TestUtils {
    public static func randomImageUrl(width: Int = 760, height: Int = 320) -> String {
        let id = Int((0...200).randomElement() ?? 0)
        return "https://picsum.photos/id/\(id)/\(width)/\(height)"
    }
}
