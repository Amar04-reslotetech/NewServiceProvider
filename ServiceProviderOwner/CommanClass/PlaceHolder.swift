//
//  PlaceHolder.swift
//  GymTimeMember
//
//  Created by MaibaMM01 on 02/09/19.
//  Copyright © 2019 maibasoft. All rights reserved.
//

import Foundation
import UIKit

class PlaceholderTextView: UITextView {
    
    @IBInspectable var placeholderColor: UIColor = UIColor.black
    @IBInspectable var placeholderText: String = ""
    
    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            setNeedsDisplay()
        }
}
}
