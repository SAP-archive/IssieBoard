//
//  Settings.swift
//  EducKeyboard
//
//  Created by Bezalel, Orit on 2/27/15.
//  Copyright (c) 2015 sap. All rights reserved.
//

import Foundation
import UIKit

// consider localizing
//let defaultBackgroundColor_preferenceID = "defaultBackgroundColor"
//let defaultKeyColor_preferenceID = "defaultKeyColor"
//let defaultTextColor_preferenceID = "defaultTextColor"
//let specialKeysColor_preferenceID = "specialKeysColor"
//
//let hiddenkeys_preferenceID = "hiddenKeys"
//
//let charsetOne_preferenceID = "charsetOne"
//let charsetOneKeyColor_preferenceID = "charsetOneKeyColor"
//let charsetOneTextColor_preferenceID = "charsetOneTextColor"
//
//let charsetTwo_preferenceID = "charsetTwo"
//let charsetTwoKeyColor_preferenceID = "charsetTwoKeyColor"
//let charsetTwoTextColor_preferenceID = "charsetTwoTextColor"
//
//let charsetThree_preferenceID = "charsetThree"
//let charsetThreeKetColor_preferenceID = "charsetThreeKetColor"
//let charsetThreeTextColor_preferenceID = "charsetThreeTextColor"

extension UIColor {
    convenience init(rgba: String) {
        
        var redf = ((rgba as NSString).substringFromIndex(0) as NSString).substringToIndex(6)
        var greenf = ((rgba as NSString).substringFromIndex(7) as NSString).substringToIndex(6)
        var bluef = ((rgba as NSString).substringFromIndex(14) as NSString).substringToIndex(6)
        var alphaf = ((rgba as NSString).substringFromIndex(21) as NSString).substringToIndex(6)
    
        var red:   CGFloat = CGFloat(NSNumberFormatter().numberFromString(redf)!)
        var green: CGFloat = CGFloat(NSNumberFormatter().numberFromString(greenf)!)
        var blue:  CGFloat = CGFloat(NSNumberFormatter().numberFromString(bluef)!)
        var alpha: CGFloat = CGFloat(NSNumberFormatter().numberFromString(alphaf)!)
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

class Settings {
    
    let defaultBackgroundColor_preferenceID = "defaultBackgroundColor"
    let defaultKeyColor_preferenceID = "defaultKeyColor"
    let defaultTextColor_preferenceID = "defaultTextColor"
    let specialKeysColor_preferenceID = "specialKeysColor"
    
    let hiddenkeys_preferenceID = "hiddenKeys"
    
    let charsetOne_preferenceID = "charsetOne"
    let charsetOneKeyColor_preferenceID = "charsetOneKeyColor"
    let charsetOneTextColor_preferenceID = "charsetOneTextColor"
    
    let charsetTwo_preferenceID = "charsetTwo"
    let charsetTwoKeyColor_preferenceID = "charsetTwoKeyColor"
    let charsetTwoTextColor_preferenceID = "charsetTwoTextColor"
    
    let charsetThree_preferenceID = "charsetThree"
    let charsetThreeKetColor_preferenceID = "charsetThreeKetColor"
    let charsetThreeTextColor_preferenceID = "charsetThreeTextColor"

    var userDefaults : NSUserDefaults
    
    class var sharedInstance: Settings {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Settings? = nil
        }
        
        dispatch_once(&Static.onceToken) {
            Static.instance = Settings()
        }
        
        return Static.instance!
    }
    
    init() {
        self.userDefaults = NSUserDefaults(suiteName: "group.com.sap.i012387.HashtagPOC")!
    }
    
    var allCharsInKeyboard : String {
        get{
            return "אבגדהוזחטיכלמנסעןפצקרשתםףךץ1234567890.,?!'•_\\|~<>$€£[]{}#%^*+=.,?!'\"-/:;()₪&@"
        }
    }

    var defaultBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_BACKGROUND_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetKeysOneBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET1_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetKeysTwoBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET2_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetKeysThreeBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET3_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetTextKeysOneBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET1_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetTextKeysTwoBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET2_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetTextKeysThreeBackgroundColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET3_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var visibleKeys : String {
        get {
            if userDefaults.stringForKey("ISSIE_KEYBOARD_VISIBLE_KEYS") == nil{
                return ""
            }
            else{
                var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_VISIBLE_KEYS")!
                return cString
            }
        }
    }
    
    var SpecialKeyColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var SpecialKeyTextColor : UIColor {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var SpecialKeys : String {
        get {
            if userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT") == nil{
                return ""
            }
            else{
                var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT")!
                return cString
            }
        }
    }
    
    
    var RowOrCol : String {
        get {
            var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_ROW_OR_COLUMN")!
            return cString
        }
    }
    
    var Font : String {
        get {
            if userDefaults.stringForKey("ISSIE_KEYBOARD_FONT") == nil{
                return "Arial"
            }
            else{
                var cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_FONT")!
                return cString
            }
        }
    }
   
    func defaultsChanged(notification: NSNotification) {
        let defaults = notification.object as! NSUserDefaults
        var i : Int = defaults.integerForKey(defaultBackgroundColor_preferenceID)
        //self.updateKeyCaps(/*self.shiftState.uppercase()*/)
    }
}
//        NSUserDefaults.standardUserDefaults().registerDefaults([
//            defaultBackgroundColor_preferenceID: 3,
//            defaultKeyColor_preferenceID: 6,
//            defaultTextColor_preferenceID: 3,
//            specialKeysColor_preferenceID: 3
//            ])
//
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("defaultsChanged:"), name: NSUserDefaultsDidChangeNotification, object: nil)
     
//    var defaultKeyColor : UIColor
//    var defaultTextColor : UIColor
//    var specialKeysColor : UIColor
//    
//    var hiddenKeys : String
//    
//    var charsetOne : String
//    var charsetOneKeyColor : UIColor
//    var charsetOneTextColor : UIColor
//
//    var charsetTwo : String
//    var charsetTwoKeyColor : UIColor
//    var charsetTwoTextColor : UIColor
//    
//    var charsetThree : String
//    var charsetThreeKeyColor : UIColor
//    var charsetThreeTextColor : UIColor
//     func getColor(hex : String ) -> UIColor {
//
//        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
//        
//        if (cString.hasPrefix("#")) {
//            cString = (cString as NSString).substringFromIndex(1)
//        }
//        
//        if (count(cString) == 6) {
//            return UIColor.grayColor()
//        }
//        
//        var rString = (cString as NSString).substringToIndex(2)
//        var gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
//        var bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
//        
//        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
//        NSScanner(string: rString).scanHexInt(&r)
//        NSScanner(string: gString).scanHexInt(&g)
//        NSScanner(string: bString).scanHexInt(&b)
//
//        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
//        switch color {
//        case 0:
//            return UIColor.redColor()
//        case 1:
//            return UIColor.greenColor()
//        case 2:
//            return UIColor.blueColor()
//        case 3:
//            return UIColor.blackColor()
//        case 4 :
//            return UIColor.whiteColor()
//        case 5 :
//            return UIColor.grayColor()
//        case 6 :
//            return UIColor.yellowColor()
//        case 7 :
//            return UIColor.orangeColor()
//            
//        default :
//            return UIColor.blackColor()
//        }
//    }
//    class var defaultBackgroundColor : UIColor {
//        get {return UIColor.orangeColor()}
//        set {GlobalColors.defaultBackgroundColor = newValue}
//    }
//    
//    class var defaultTextColor : UIColor {
//        get {return UIColor.blueColor()}
//        set {GlobalColors.defaultTextColor = newValue}
//    }
//    
//    class var defaultKeyColor : UIColor {
//        get {return UIColor.whiteColor()}
//        set {GlobalColors.defaultTextColor = newValue}
//    }
//    
//    class var defaultBorderColor : UIColor {
//        get { return UIColor.whiteColor()}
//        set { GlobalColors.defaultKeyColor = newValue}
//    }
//    
//    class var backspaceKeyColor : UIColor {
//        get { return UIColor.redColor() }
//        set { GlobalColors.backspaceKeyColor = newValue}
//    }
//    class var spaceKeyColor : UIColor {
//        get { return GlobalColors.defaultKeyColor}
//        set { GlobalColors.spaceKeyColor = newValue}
//    }
//    
//    class var returnKeyColor : UIColor {
//        get { return UIColor.greenColor()}
//        set { GlobalColors.returnKeyColor = newValue}
//    }
//    
//    class var changeModeKeyColor : UIColor {
//        get { return UIColor.grayColor()}
//        set { GlobalColors.changeModeKeyColor = newValue}
//    }
//    
//    //Settings for area One
//    
//    class var cutomCharSetOneKeyColor : UIColor {
//        get { return GlobalColors.defaultKeyColor}
//        set { GlobalColors.cutomCharSetOneKeyColor = newValue}
//    }
//    
//    class var cutomCharSetOneTextColor : UIColor {
//        get { return UIColor.redColor()}//GlobalColors.defaultTextColor}
//        set { GlobalColors.cutomCharSetOneTextColor = newValue}
//    }
//    
//    class var cutomCharSetOneBorderColor : UIColor {
//        get { return GlobalColors.defaultBorderColor}
//        set { GlobalColors.cutomCharSetOneBorderColor = newValue}
//        
//    }
//    //Settings for ares two
//    class var cutomCharSetTwoKeyColor : UIColor {
//        get { return UIColor.yellowColor()}
//        set { GlobalColors.cutomCharSetTwoKeyColor = newValue}
//    }
//    
//    class var cutomCharSetTwoTextColor : UIColor {
//        get { return UIColor.blackColor()}
//        set { GlobalColors.cutomCharSetTwoTextColor = newValue}
//    }
//    
//    class var cutomCharSetTwoBorderColor : UIColor {
//        get { return GlobalColors.defaultBorderColor}
//        set { GlobalColors.cutomCharSetTwoBorderColor = newValue}
//    }
//    
//    //Settings for area three
//    class var cutomCharSetThreeKeyColor : UIColor {
//        get { return GlobalColors.defaultKeyColor}
//        set { GlobalColors.cutomCharSetThreeKeyColor = newValue}
//    }
//    
//    class var cutomCharSetThreeTextColor : UIColor {
//        get { return GlobalColors.defaultTextColor}
//        set { GlobalColors.cutomCharSetThreeTextColor = newValue}
//    }
//    
//    class var cutomCharSetThreeBorderColor : UIColor {
//        get { return GlobalColors.defaultBorderColor}
//        set { GlobalColors.cutomCharSetThreeBorderColor = newValue}
//    }
//    
//    //Settings for hidden keys
//    class var hiddenKeyColor : UIColor {
//        get  { return GlobalColors.defaultBackgroundColor}
//    }
//    
//    class var keyFont  : UIFont {
//        get { return UIFont(name: "trashimclm-bold", size:50)!}
//    }
//
//    
//    
//
//    init () {
//        defaults = NSUserDefaults.standardUserDefaults()
//    }