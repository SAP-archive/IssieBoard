//
//  ColorUtility.swift
//  IssieKeyboard
//
//  Created by Sasson, Kobi on 3/20/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }

    var isEmptyOrWhiteSpace : Bool { return self.isEmpty || self.isWhiteSpace }
    var isWhiteSpace        : Bool { return !self.isEmpty && self.trim().isEmpty }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }

}

extension UIColor {
    
    convenience init(rgba: String) {
        
        let redf = ((rgba as NSString).substringFromIndex(0) as NSString).substringToIndex(6)
        let greenf = ((rgba as NSString).substringFromIndex(7) as NSString).substringToIndex(6)
        let bluef = ((rgba as NSString).substringFromIndex(14) as NSString).substringToIndex(6)
        let alphaf = ((rgba as NSString).substringFromIndex(21) as NSString).substringToIndex(6)
        
        let red:   CGFloat = CGFloat(NSNumberFormatter().numberFromString(redf)!)
        let green: CGFloat = CGFloat(NSNumberFormatter().numberFromString(greenf)!)
        let blue:  CGFloat = CGFloat(NSNumberFormatter().numberFromString(bluef)!)
        let alpha: CGFloat = CGFloat(NSNumberFormatter().numberFromString(alphaf)!)
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    convenience init(string: String) {
        let array = string.characters.split{$0 == ","}.map { String($0) }
        assert(array.count == 4, "Invalid string schema" )
        let (r,g,b,a) = (CGFloat(array[0].floatValue),CGFloat(array[1].floatValue),CGFloat( array[2].floatValue), CGFloat(array[3].floatValue))
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    var stringValue:String?  {
        get{
            var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0
            var a:CGFloat = 0
            
            if self.getRed(&r, green: &g, blue: &b, alpha: &a){
                let colorText = NSString(format: "%4.4f,%4.4f,%4.4f,%4.4f",
                    Float(r),Float(g),Float(b),Float(a))
                return colorText as String
            }
            return nil
        }
    }
}
