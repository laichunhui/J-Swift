
import Foundation

public class FileUtils: NSObject {

    /**doc path*/
    public static func sysDocumentPath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return path.first!
    }
    
    /**caches path*/
    public static func sysLibCachesPath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        return path.first!
    }
    
    /**file exists*/
    public static func fileExists(path: String?) -> Bool {
        guard let path, !path.isEmpty else {
            return false
        }
        
        var isDir = ObjCBool.init(false)
        return FileManager.default.fileExists(atPath: path, isDirectory: &isDir)
    }
    
    /**create by path*/
    public static func create(path: String) -> Bool {
        let exist = FileUtils.fileExists(path: path)
        if exist {
            return false
        }
        
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    /**remove by path*/
    public static func remove(path: String?) -> Bool {
        if !FileUtils.fileExists(path: path) {
            return false
        }
        
        do {
            try FileManager.default.removeItem(atPath: path!)
            print("Remove path: \(path!)")
            return true
        } catch  {
            print(error)
        }
        return false
    }
}
