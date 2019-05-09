//
//  ImageManager.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 16/10/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage
import AVKit
import Photos
import AssetsLibrary

extension UIImage{
    
    // it returns a square thumbnail.
    func getAssetThumbnail(asset: PHAsset, size: CGFloat) -> UIImage? {
        let retinaScale = UIScreen.main.scale
        let retinaSquare = CGSize(width: size * retinaScale, height: size * retinaScale)
        let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
        let square = CGRect(x: 0, y: 0, width: CGFloat(cropSizeLength), height: CGFloat(cropSizeLength))
        let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail : UIImage? = UIImage()
        
        options.isSynchronous = true
        options.deliveryMode = .fastFormat
        options.resizeMode = .exact
        options.normalizedCropRect = cropRect
        
        manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            if let boolVal = info!["PHImageResultIsInCloudKey"] as? Bool{
                if !boolVal{
                    thumbnail = result
                }
            }
        })
        return thumbnail
    }
    
    // it returns a square thumbnail.
    func getAssetThumbnail(asset: PHAsset) -> UIImage? {
        
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail : UIImage? = UIImage()
        
        options.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
