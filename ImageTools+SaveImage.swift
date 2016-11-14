//
//  ImageTools+SaveImage.swift
//  ImageTools
//
//  Created by Zhang on 14/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

import UIKit

class SaveImageTools{
    
    private init(){}
    
    static let sharedInstance = SaveImageTools()
    
    func getCachesDirectoryUserInfoDocumetPathDocument(user:String, document:String) ->String? {
        let manager = NSFileManager.defaultManager()
        let path = kEncodeUserCachesDirectory.stringByAppendingString("/\(user)").stringByAppendingString("/\(document)")
        if !manager.fileExistsAtPath(path) {
            do {
                try manager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
                return path
            } catch {
                print("创建失败")
                return nil
            }
        }else{
            return path
        }
    }
    
    
    func saveImage(name:String, image:UIImage, path:String) -> Bool {
        let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("002", document: path)
        if saveFilePath == nil {
            return false
        }
        let saveName = saveFilePath?.stringByAppendingString("/\(name)")
        let imageData = UIImagePNGRepresentation(image)
        self.saveSmallImage(name, image: image, path: path)
        return (imageData?.writeToFile(saveName!, atomically: true))!
    }
    
    func saveSmallImage(name:String, image:UIImage, path:String) -> Bool {
        let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("002", document: path)
        if saveFilePath == nil {
            return false
        }
        let saveName = saveFilePath?.stringByAppendingString("/\(name)")
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        return (imageData?.writeToFile(saveName!, atomically: false))!
    }
    
    func LoadImage(name:String, path:String) -> UIImage? {
        let saveFilePath = self.getCachesDirectoryUserInfoDocumetPathDocument("002", document: path)
        let saveName = saveFilePath?.stringByAppendingString("/\(name)")
        let data = NSData.init(contentsOfFile: saveName!)
        if data == nil {
            return nil
        }
        return UIImage.init(data: data!)
    }
    
}

