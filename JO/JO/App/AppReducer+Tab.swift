//
//  AppReducer+Tab.swift
//  Hazar
//
//  Created by work on 5/11/24.
//

import Foundation
import SwiftUI

extension AppReducer {
    public enum Route: String, CaseIterable {
        case home
        case chat
        case me

        public var icon: Image {
            var image = Image("")
            switch self {
            case .home:
                image = Image(R.image.tabbar.home_normal)
            case .chat:
                image = Image(R.image.tabbar.message_normal)
            case .me:
                image = Image(R.image.tabbar.me_normal)
            }
            return image
        }
        
        public var selectedIcon: Image {
            var image = Image("")
            switch self {
            case .home:
                image = Image(R.image.tabbar.home_normal)
            case .chat:
                image = Image(R.image.tabbar.message_normal)
            case .me:
                image = Image(R.image.tabbar.me_normal)
            }
            return image
        }
        
        public var title: String {
            var title = ""
            switch self {
            case .home:
                title = "Home"
            case .chat:
                title = "Chats"
            case .me:
                title = "Me"
            }
            return title
        }
    }
}
