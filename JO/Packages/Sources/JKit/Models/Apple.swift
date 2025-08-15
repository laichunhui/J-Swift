//
//  File.swift
//  
//
//  Created by JerryLai on 2023/7/11.
//

import Foundation

public struct AppStoreInfo: Codable {
    public let resultCount: Int?
    public let results: [AppInfoResult]?
}

public struct AppInfoResult: Codable {
    public let advisories: [String]?
    public let averageUserRating: Float?
    public let averageUserRatingForCurrentVersion : Float?
    public let bundleId: String?
    public let contentAdvisoryRating: String?
    public let currency: String?
    public let features: [String]?
    public let fileSizeBytes: String?
    public let genreIds: [String]?
    public let genres: [String]?
    public let isGameCenterEnabled: Bool?
    public let kind: String?
    public let languageCodesISO2A: [String]?
    public let primaryGenreId: Int?
    public let primaryGenreName: String?
    public let releaseDate: String?
    public let releaseNotes: String?
    public let screenshotUrls: [String]?
    public let sellerName: String?
    public let trackCensoredName: String?
    public let trackContentRating: String?
    public let trackId: Int?
    public let trackName: String?
    public let trackViewUrl: String?
    public let version: String?
}

public enum PhotoPickerType: Identifiable {
    case camera
    case library
    
    public var id: PhotoPickerType { self }
}
