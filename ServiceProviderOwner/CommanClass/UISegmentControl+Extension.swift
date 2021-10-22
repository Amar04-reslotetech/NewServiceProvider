//
//  UISegmentControl+Extension.swift
//  EventManagmentApp
//
//  Created by amar on 21/03/19.
//  Copyright © 2019 amar. All rights reserved.
//

import Foundation
import UIKit



extension UISegmentedControl {
    
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
//        self.setTitleTextAttributes(NSAttributedString.Key.foregroundColor, for: .normal)
//        self.setTitleTextAttributes(NSAttributedString.Key.foregroundColor, for: .normal)
//        self.setTitleTextAttributes([:], for: .normal)
//                self.setTitle(f, forSegmentAt: <#T##Int#>)
      
       
      
//        UISegmentedControl.setTitleTextAttributes(font, for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:1.0)], for: .selected)
       
        
        
    }
    
    func setFontSize(fontSize: CGFloat) {
        
        let normalTextAttributes: [NSObject : AnyObject] = [
            NSAttributedString.Key.foregroundColor as NSObject: UIColor.black,
            NSAttributedString.Key.font as NSObject: UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(5))
        ]
        
        let boldTextAttributes: [NSObject : AnyObject] = [
            NSAttributedString.Key.foregroundColor as NSObject : UIColor.blue,
            NSAttributedString.Key.font as NSObject : UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium),
        ]
        
        self.setTitleTextAttributes(normalTextAttributes as! [NSAttributedString.Key : Any], for: .normal)
//        self.setTitleTextAttributes(normalTextAttributes as! [NSAttributedString.Key : Any], for: .normal)
//        self.setTitleTextAttributes(boldTextAttributes as! [NSAttributedString.Key : Any], for: .normal)
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 3.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(red:18/255, green: 68/255, blue: 121/255, alpha: 0.83)
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}


