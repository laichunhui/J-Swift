//
//  File.swift
//  
//
//  Created by Summer wu on 2024/4/1.
//

import Foundation
import UIKit

public enum ImageSize {
    case small
    case medium
    case large
    case original
    
    /// 拼接缩放比例
    public var imageSale: String {
        switch self {
        case .small:
            return "image/resize,l_200"
        case .medium:
            return "image/resize,l_400"
        case .large:
            return "image/resize,l_800"
        case .original:
            return ""
        }
    }
    
    @MainActor
    public var size: CGFloat {
        switch self {
        case .small:
            return 200
        case .medium:
            return 400
        case .large:
            return 800
        case .original:
            return kScreenWidth
        }
    }
    
    /// 压缩率
    public var compressionSize: Int {
        switch self {
        case .small:
            return 100 * 1024
        case .medium:
            return 800 * 1024
        case .large:
            return 1024 * 1024
        case .original:
            return 0
        }
    }
    
    public var profileIconSize: String {
        switch self {
        case .small:
            return "image/resize,l_50"
        case .medium:
            return "image/resize,l_100"
        case .large:
            return "image/resize,l_200"
        case .original:
            return ""
        }
    }
    
    public static func from(userIconSize: CGSize?) -> ImageSize {
        guard let userIconSize = userIconSize  else {
            return .original
        }
        
        var imgSize = ImageSize.small
        if userIconSize.width >= 100 {
            imgSize = .large
        } else if userIconSize.width >= 20 {
            imgSize = .medium
        }
        
        return imgSize
    
    }
    
    /// 裁剪前缀
    public static let resizePrefixKey = "x-oss-process=image"
}

public enum ImageUploadStatus: String {
    case failure
    case success
    case illegal
    case ready
    
//    public static var columnType: ColumnType {
//        return .text
//    }
//
//    public init?(with value: FundamentalValue) {
//        if let status = Self.init(rawValue: value.stringValue) {
//            self = status
//        }
//        else {
//            return nil
//        }
//    }
//    public func archivedValue() -> FundamentalValue {
//        return FundamentalValue(self.rawValue)
//    }
}

public class WGImageUploadModel {
    public var index: Int = 0
    public var md5Value: String
    public var imageData: Data
    public var status: ImageUploadStatus = .ready
    public var ossKeyPath: String
    
//    public enum CodingKeys: String, CodingTableKey {
//        public typealias Root = FeedImageUploadModel
//        public static let objectRelationalMapping = TableBinding(CodingKeys.self)
//        case md5Value
//        case imageData
//        case status
//        case ossKeyPath
//    }
    
//    public init(index: Int = 0, image: UIImage, imageSaleType: ImageSize, status: ImageUploadStatus = .ready, savePathType: WGImageSavePathType, uid: String?) {
//        self.index = index
////        let imageData = YQImageCompressTool.onlyCompressToData(with: image.resizeImage(newWidth: imageSaleType.size), fileSize: imageSaleType.compressionSize) ?? Data()
//        let imageData = UIImage.compressImage(image: image, toByte: imageSaleType.compressionSize) ?? Data()
//        self.md5Value = imageData.md5
//        self.imageData = imageData
//        self.status = status
//        self.ossKeyPath = "\(savePathType.path(uid: uid))\(imageData.md5).\(imageData.getImageFormat().rawValue)"
//    }
//    
//    public init(index:Int = 0, fileData:Data, fileName:String, status: ImageUploadStatus = .ready, savePathType: WGImageSavePathType, uid: String?) {
//        self.index = index
//        let imageData = fileData
//        self.md5Value = imageData.md5
//        self.imageData = imageData
//        self.status = status
//        self.ossKeyPath = "\(savePathType.path(uid: uid))\(imageData.md5)_\(fileName)"
//    }
    
    public init(index:Int = 0, ossPath: String, md5: String) {
        self.index = index
        self.md5Value = md5
        self.imageData = Data()
        self.status = .success
        self.ossKeyPath = ossPath
    }
}
