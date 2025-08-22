import Foundation
import SwiftUI
import JKit
import Security

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        JApp.appStore.send(.appDelegate(.appDidFinishLaunching))
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
}

extension AppDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {


        let configuration = UISceneConfiguration(
                                name: nil,
                                sessionRole: connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            configuration.delegateClass = SceneDelegate.self
        }
        return configuration
    }
}


class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
//    func windowScene(
//        _ windowScene: UIWindowScene,
//        performActionFor shortcutItem: UIApplicationShortcutItem
//    ) async -> Bool {
//        return true
//    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        if url.scheme == "appScope.scheme" {
            JApp.appStore.send(.open(url: url))
        }
    }
}
