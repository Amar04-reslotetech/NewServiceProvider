//
//  UIImage+Extensions.swift
//  EventManagmentApp
//
//  Created by amar on 21/03/19.
//  Copyright © 2019 amar. All rights reserved.
//

import Foundation
import UIKit


extension UIImage{
    
    enum Icons {
        
        static var addIcon:UIImage?
        {
            return UIImage(named: "add_icon")
        }
        
        static var navHamburger: UIImage? {
            return UIImage(named: "menu_burger_white")
        }
        
        static var navDropDown: UIImage? {
            return  UIImage(named: "drop_down_arrow_white")
        }
        
        static var noNetwork: UIImage? {
            return #imageLiteral(resourceName: "ic_no_network")
        }
        
        static var serverError: UIImage? {
            return #imageLiteral(resourceName: "ic_server_error")
        }
        
        static var aboutusRateus: UIImage? {
            return #imageLiteral(resourceName: "ic_about_googlePlay")
        }
        static var aboutusFaceBook: UIImage? {
            return #imageLiteral(resourceName: "ic_about_Fb")
        }
        static var aboutusTerms: UIImage? {
            return #imageLiteral(resourceName: "ic_about_Terms")
        }
        static var aboutusPrivacy: UIImage? {
            return #imageLiteral(resourceName: "ic_about_Privacy")
        }
        static var aboutusReportBugs: UIImage? {
            return #imageLiteral(resourceName: "ic_about_Bug")
        }
        static var aboutusSuggestions: UIImage? {
            return #imageLiteral(resourceName: "ic_about_Suggestions")
        }
        static var playAudio: UIImage? {
            return #imageLiteral(resourceName: "ic_play_small")
        }
        
        static var defaultCallBackground: UIImage? {
            return UIImage(named: "super_man.jpg")
        }
        
        static var filledCircle: UIImage? {
            return UIImage(named: "filled_circle")
        }
        
        static var pauseAudio: UIImage? {
            return #imageLiteral(resourceName: "ic_pause")
        }
        
        static var downloadMedia: UIImage? {
            return #imageLiteral(resourceName: "ic_download")
        }
        
        static var storyCellsPlaceHolder: UIImage? {
            return nil
        }
        
        static var signupFlowLogo: UIImage? {
            return UIImage(named: "ic_signupflow_logo")
        }
        
        static var storycellPlaceholder: UIImage? {
            return UIImage(named: "ic_storycell_placeholder")
        }
        
        static var shareWhite: UIImage? {
            return UIImage(named: "ic_share_white")
        }
        
        static var reportFlagWhite: UIImage? {
            return UIImage(named: "ic_report_flag_white")
        }
        
        static var refreshWhite: UIImage? {
            return UIImage(named: "ic_refresh_white")
        }
        
        static var selectedImageBlue: UIImage? {
            return UIImage(named: "ic_selected_blue")
        }
        
        static var expand: UIImage? {
            return UIImage(named: "ic_expand")
        }
        
        static var collapse: UIImage? {
            return UIImage(named: "ic_collapse")
        }
    }
    
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
    
    func imageWithColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        //let context = UIGraphicsGetCurrentContext() as CGContextRef
        //error: 'CGContext?' is not convertible to 'CGContextRef'
        //CGContextRef == CGContext, so it's saying "'CGContext?' is not convertible to 'CGContext'"
        //->you just need to unwrap it
        let context = UIGraphicsGetCurrentContext()!
        
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        //CGContextSetBlendMode(context, kCGBlendModeNormal)
        //error: use of unresolved identifier 'kCGBlendModeNormal'
        //->See the CGBlendMode constants in the CGContext Reference, it's got enum.
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
  
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageWithBackgroundColor(image: UIImage, color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        
        let imageRect = CGRect(x: (size.width/2) - (image.size.width/2), y: (size.height / 2) - (image.size.height / 2), width: image.size.width, height: image.size.height)
        image.draw(in: imageRect)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        return newImage
    }
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
    
    class func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb: Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress: Bool = true
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        while needCompress && (compressingValue > 0.0) {
//            if let data: Data = UIImageJPEGRepresentation(self, compressingValue) {
//                if data.count < sizeInBytes {
//                    needCompress = false
//                    imgData = data
//                } else {
//                    compressingValue -= 0.1
//                }
//            }
        }
        
        if let data = imgData {
            if data.count < sizeInBytes {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
