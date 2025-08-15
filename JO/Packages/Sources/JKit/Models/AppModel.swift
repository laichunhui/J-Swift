//
//  File.swift
//  
//
//  Created by Summer wu on 2024/4/8.
//

import Foundation

/// 更新信息的结构体
public struct AppInfoModel: Codable, Equatable {
    public var id: String {
        return UUID().uuidString
    }
    
    public var version: String?
    /// 是否强制更新
    public var is_force_update: Bool?
    /// 是否弹窗
    public  var is_popup: Bool?
    
    public var title: String?
    public var tips: String?
    
    /// 下载地址
    public var url: String?
    /// 信息是否来源商店。 （是，更新文案从商店来。否，更新文案从运营后台获取）
    public var is_from_store: Bool?
    
    public init(app_version: String? = nil, is_force_update: Bool? = nil, is_popup: Bool? = nil, title: String? = nil, tips: String? = nil, download_url: String? = nil, is_from_store: Bool? = nil) {
        self.version = app_version
        self.is_force_update = is_force_update
        self.is_popup = is_popup
        self.title = title
        self.tips = tips
        self.url = download_url
        self.is_from_store = is_from_store
    }
    public static func == (lhs: AppInfoModel, rhs: AppInfoModel) -> Bool {
        return lhs.id == rhs.id
    }
}
