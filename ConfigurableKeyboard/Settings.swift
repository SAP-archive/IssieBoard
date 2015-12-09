//
//  Settings.swift
//  EducKeyboard
//
//  Created by Maman, Omri on 2/27/15.
//  Copyright (c) 2015 sap. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    
    
    var Template1 : KeyboardTemplates
    var Template2 : KeyboardTemplates
    var Template3 : KeyboardTemplates
    var Template4 : KeyboardTemplates
    
    init() {
        self.userDefaults = NSUserDefaults(suiteName: "group.com.sap.i012387.HashtagPOC")!
        
        Template1 = KeyboardTemplates(
            keyboardBackgroundColor: UIColor.lightGrayColor().stringValue!,
            keysTextColor: UIColor.blackColor().stringValue!,
            keysTextColorCharset1: UIColor.blackColor().stringValue!,
            keysTextColorCharset2: UIColor.blackColor().stringValue!,
            keysTextColorCharset3: UIColor.blackColor().stringValue!,
            keysColorCharset1: UIColor.yellowColor().stringValue!,
            keysColorCharset2: UIColor.yellowColor().stringValue!,
            keysColorCharset3: UIColor.yellowColor().stringValue!,
            RowOrCol: "By Sections")
        
        Template2 = KeyboardTemplates(
            keyboardBackgroundColor: UIColor.orangeColor().stringValue!,
            keysTextColor: UIColor.blueColor().stringValue!,
            keysTextColorCharset1: UIColor.blueColor().stringValue!,
            keysTextColorCharset2: UIColor.blueColor().stringValue!,
            keysTextColorCharset3: UIColor.blueColor().stringValue!,
            keysColorCharset1: UIColor.whiteColor().stringValue!,
            keysColorCharset2: UIColor.whiteColor().stringValue!,
            keysColorCharset3: UIColor.whiteColor().stringValue!,
            RowOrCol: "By Sections")
        
        Template3 = KeyboardTemplates(
            keyboardBackgroundColor: UIColor.lightGrayColor().stringValue!,
            keysTextColor: UIColor.blackColor().stringValue!,
            keysTextColorCharset1: UIColor.blackColor().stringValue!,
            keysTextColorCharset2: UIColor.blackColor().stringValue!,
            keysTextColorCharset3: UIColor.blackColor().stringValue!,
            keysColorCharset1: UIColor.yellowColor().stringValue!,
            keysColorCharset2: UIColor.yellowColor().stringValue!,
            keysColorCharset3: UIColor.yellowColor().stringValue!,
            RowOrCol: "By Sections")
        
        Template4 = KeyboardTemplates(
            keyboardBackgroundColor: UIColor.lightGrayColor().stringValue!,
            keysTextColor: UIColor.blackColor().stringValue!,
            keysTextColorCharset1: UIColor.blackColor().stringValue!,
            keysTextColorCharset2: UIColor.blackColor().stringValue!,
            keysTextColorCharset3: UIColor.blackColor().stringValue!,
            keysColorCharset1: UIColor.yellowColor().stringValue!,
            keysColorCharset2: UIColor.yellowColor().stringValue!,
            keysColorCharset3: UIColor.yellowColor().stringValue!,
            RowOrCol: "By Sections")
        
        
    }
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
    
    var allCharsInKeyboard : String {
        get{
            return "אבגדהוזחטיכלמנסעןפצקרשתםףךץ1234567890.,?!'•_\\|~<>$€£[]{}#%^*+=.,?!'\"-/:;()₪&@"
        }
    }
    
    var defaultBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_BACKGROUND_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetKeysOneBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET1_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetKeysTwoBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET2_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetKeysThreeBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET3_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetTextKeysOneBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET1_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetTextKeysTwoBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET2_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var charsetTextKeysThreeBackgroundColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_CHARSET3_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var visibleKeys : String {
        get {
            if userDefaults.stringForKey("ISSIE_KEYBOARD_VISIBLE_KEYS") == nil{
                return ""
            }
            else{
                let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_VISIBLE_KEYS")!
                return cString
            }
        }
    }
    
    var SpecialKeyColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    
    var SpecialKeyTextColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var SpecialKeys : String {
        get {
            if userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT") == nil{
                return ""
            }
            else{
                let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT")!
                return cString
            }
        }
    }
    
    var RowOrCol : String {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_ROW_OR_COLUMN")!
            return cString
        }
    }
    
    var Font : String {
        get {
            if userDefaults.stringForKey("ISSIE_KEYBOARD_FONT") == nil{
                return "Arial"
            }
            else{
                let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_FONT")!
                return cString
            }
        }
    }
    
    
    var currentTemplate : String {
        get {
    
                let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_TEMPLATES")!
                return cString
        }
    }
    
    
    /// FIXED KEYS COLORS - START ///
    
    var SpaceColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_SPACE_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var BackspaceColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_BACKSPACE_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var EnterColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_ENTER_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    var OtherKeysColor : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("ISSIE_KEYBOARD_OTHERDEFAULTKEYS_COLOR")!
            return UIColor(rgba: cString)
        }
    }
    
    /// FIXED KEYS COLORS - END///
    
    
    // AREA KEYBOARD COLORS - START//
    
    var AreaKeyboard1 : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("AREA_KEYBOARD_1")!
            return UIColor(rgba: cString)
        }
    }

    var AreaKeyboard2 : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("AREA_KEYBOARD_2")!
            return UIColor(rgba: cString)
        }
    }

    var AreaKeyboard3 : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("AREA_KEYBOARD_3")!
            return UIColor(rgba: cString)
        }
    }

    var AreaKeyboard4 : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("AREA_KEYBOARD_4")!
            return UIColor(rgba: cString)
        }
    }

    var AreaKeyboard5 : UIColor {
        get {
            let cString: String = userDefaults.stringForKey("AREA_KEYBOARD_5")!
            return UIColor(rgba: cString)
        }
    }
    
    // AREA KEYBOARD COLORS - END//

    
    
    
    
    func GetKeyColorByTemplate (model : Key) -> UIColor {
        
        var TemplateType = ["Template1 - Yellow", "Template2 - Orange", "Template3", "Template4"]
        
        switch self.currentTemplate {
        case TemplateType[0]:
            
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: self.Template1.KeysColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: self.Template1.KeysColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: self.Template1.KeysColorCharset3)
            default:
                return UIColor(string: self.Template1.KeysColorCharset3)
            }
            
        case TemplateType[1]:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: self.Template2.KeysColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: self.Template2.KeysColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: self.Template2.KeysColorCharset3)
            default:
                return UIColor(string: self.Template2.KeysColorCharset3)
            }
            
        case TemplateType[2]:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: self.Template3.KeysColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: self.Template3.KeysColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: self.Template3.KeysColorCharset3)
            default:
                return UIColor(string: self.Template3.KeysColorCharset3)
            }
            
        case TemplateType[3]:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: self.Template4.KeysColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: self.Template4.KeysColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: self.Template4.KeysColorCharset3)
            default:
                return UIColor(string: self.Template4.KeysColorCharset3)
            }
        default:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return self.charsetKeysOneBackgroundColor
            case Key.KeyType.CustomCharSetTwo:
                return self.charsetKeysTwoBackgroundColor
            case Key.KeyType.CustomCharSetThree:
                return self.charsetKeysThreeBackgroundColor
            default:
                return self.charsetKeysThreeBackgroundColor
            }
        }
    }
    
    func GetKeyTextColorByTemplate(model : Key) -> UIColor {
        
        var TemplateType = ["Template1 - Yellow", "Template2 - Orange", "Template3", "Template4"]
        
        switch self.currentTemplate {
        case TemplateType[0]:
            
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: Template1.KeysTextColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: Template1.KeysTextColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: Template1.KeysTextColorCharset3)
            default:
                return UIColor(string: Template1.KeysTextColorCharset3)
            }
            
        case TemplateType[1]:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: Template2.KeysTextColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: Template2.KeysTextColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: Template2.KeysTextColorCharset3)
            default:
                return UIColor(string: Template2.KeysTextColorCharset3)
            }
            
        case TemplateType[2]:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: Template3.KeysTextColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: Template3.KeysTextColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: Template3.KeysTextColorCharset3)
            default:
                return UIColor(string: Template3.KeysTextColorCharset3)
            }
            
        case TemplateType[3]:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return UIColor(string: Template4.KeysTextColorCharset1)
            case Key.KeyType.CustomCharSetTwo:
                return UIColor(string: Template4.KeysTextColorCharset2)
            case Key.KeyType.CustomCharSetThree:
                return UIColor(string: Template4.KeysTextColorCharset3)
            default:
                return UIColor(string: Template4.KeysTextColorCharset3)
            }
        default:
            switch model.type {
            case Key.KeyType.CustomCharSetOne:
                return self.charsetTextKeysOneBackgroundColor
            case Key.KeyType.CustomCharSetTwo:
                return self.charsetTextKeysTwoBackgroundColor
            case Key.KeyType.CustomCharSetThree:
                return self.charsetTextKeysThreeBackgroundColor
            default:
                return self.charsetTextKeysThreeBackgroundColor
            }
        }
    }
    
    func GetBackgroundColorByTemplate() -> UIColor {
        
        var TemplateType = ["Template1 - Yellow", "Template2 - Orange", "Template3", "Template4"]
        
        switch self.currentTemplate {
        case TemplateType[0]:
            return UIColor(string: Template1.KeyboardBackgroundColor)
        case TemplateType[1]:
            return UIColor(string: Template2.KeyboardBackgroundColor)
        case TemplateType[2]:
            return UIColor(string: Template3.KeyboardBackgroundColor)
        case TemplateType[3]:
            return UIColor(string: Template4.KeyboardBackgroundColor)
        default:
            return self.defaultBackgroundColor
        }
    }
    
}