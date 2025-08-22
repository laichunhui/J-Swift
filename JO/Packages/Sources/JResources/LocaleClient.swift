//
//  LocaleClient.swift
//  TGResources
//
//  Created by tg2024 on 2024/5/30.
//

import Combine
import Foundation

func customLocalizedString(forKey key: String, table tableName: String?, value: String?)-> String {
    return LocaleClient.shared.localizedString(forKey: key, value: value, table: tableName)
}

public enum LocaleType: String, CaseIterable {
    case en
    case zhHans
    case ar
    public var languageCode: String {
        switch self {
        case .en:
            return "en"
        case .zhHans:
            return "zh-Hans"
        case .ar:
            return "ar"
        }
    }
    
    public var name: String {
        switch self {
        case .en:
            return "English"
        case .zhHans:
            return "中文"
        case .ar:
            return "Arabic"
        }
    }
    
//    public var icon: ImageAsset {
//        switch self {
//        case .en:
//            return Asset.Lang.en
//        case .zhHans:
//            return Asset.Lang.en
//        case .ar:
//            return Asset.Lang.ar
//        }
//    }
}

public class LocaleClient {
    struct Metric {
        static let languageKey = "hazar_language"
    }
    
    @Published public var lang: LocaleType = .en
    nonisolated(unsafe) public static let shared: LocaleClient = LocaleClient()
    var bundle: Bundle
//    public let curLang: CurrentValueSubject<LocaleType, Never> = .init(.en)
    private var cancellables = Set<AnyCancellable>()
    public var isCNLang: Bool {
        return lang == .zhHans
    }
    public var isARLang: Bool {
        return lang == .ar
    }
   static private var moduleBundle: Bundle {
       return Bundle(url: Bundle.main.url(forResource: "Packages_TGResources.bundle", withExtension: "")!)!
    }
    
    private init() {
        var lang = LocaleType.en
        if let value = UserDefaults.standard.value(forKey: Metric.languageKey) as? String, let cacheType = LocaleType(rawValue: value) {
            lang = cacheType
        }
        self.bundle =
        Bundle(path: LocaleClient.moduleBundle.path(forResource: lang.languageCode, ofType: "lproj")!)!
        self.lang = lang
    }
    
    public func set(locale: LocaleType) {
        guard let path = LocaleClient.moduleBundle.path(forResource: locale.languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            fatalError("Failed to find path for language: \(locale)")
        }
        self.bundle = bundle
        self.lang = locale
        UserDefaults.standard.setValue(locale.rawValue, forKey: Metric.languageKey)
    }
    
    public func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}


//struct TGLocaleTypeKey: EnvironmentKey {
//    static var defaultValue: LocaleClient.LocaleType = .en
//    
//}
//
//extension EnvironmentValues {
//    var tgLocaleType: LocaleClient.LocaleType {
//        get { self[TGLocaleTypeKey.self] }
//        set { self[TGLocaleTypeKey.self] = newValue }
//    }
//}

//MARK: 字符适配
extension LocaleClient {
    public enum Character {
        public static let slash = LocaleClient.shared.isARLang ? "\\" : "/"
    }
}
