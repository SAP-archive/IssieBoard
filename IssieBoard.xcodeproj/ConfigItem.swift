//
//  ConfigItem.swift
//  MasterDetailsHelloWorld
//
//  Created by Sasson, Kobi on 3/14/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import Foundation
import UIKit

enum ControlsType {
    case TextInput
    case ColorPicker
}

enum ConfigItemType{
    case String
    case Color
    case Picker
    case FontPicker
    case Templates
}

class ConfigItem {
    
    var UserSettings: NSUserDefaults
    let key: String
    let title: String
    let type: ConfigItemType
    let defaultValue: AnyObject?
    
    var value: AnyObject? {
        get{
            switch self.type{
            case .String:
                if let val = UserSettings.stringForKey(self.key) {
                    return val
                } else{
                    return self.defaultValue
                }
            case .Color:
                if let val = UserSettings.stringForKey(self.key) {
                    return UIColor(string: val)
                } else{
                    return defaultValue
                }
            case .Templates:
                if let val = UserSettings.objectForKey(self.key) as? NSDictionary {
                    return val
                } else {
                    return self.defaultValue
                }
            default:
                if let val = UserSettings.stringForKey(self.key) {
                    return val
                } else{
                    return self.defaultValue
                }
            }
        }
        set {
            switch self.type{
            case .String:
                UserSettings.setObject(newValue, forKey: self.key)
                UserSettings.synchronize()
            case .Color:
                if let color = (newValue as! UIColor).stringValue {
                    UserSettings.setObject(color, forKey: self.key)
                    UserSettings.synchronize()
                }
            default:
                UserSettings.setObject(newValue, forKey: self.key)
                UserSettings.synchronize()
            }
        }
    }
    
    init(key:String ,title: String, defaultValue: AnyObject?, type: ConfigItemType ){
        UserSettings = NSUserDefaults(suiteName: "group.com.sap.i012387.HashtagPOC")!
        self.key = key
        self.title = title
        self.type = type
        self.defaultValue = defaultValue
        
        switch self.type{
        case .String:
            UserSettings.setObject(defaultValue, forKey: self.key)
            UserSettings.synchronize()
        case .Color:
            if let color = (defaultValue as! UIColor).stringValue {
                UserSettings.setObject(color, forKey: self.key)
                UserSettings.synchronize()
            }
        default:
            UserSettings.setObject(defaultValue, forKey: self.key)
            UserSettings.synchronize()
        }
    }
}