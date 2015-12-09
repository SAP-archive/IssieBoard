//
//  KeyboardTemplates.swift
//  EasyBoard
//
//  Created by Maman, Omri on 15/06/15.
//  Copyright (c) 2015 sap. All rights reserved.
//

import Foundation
import UIKit

class KeyboardTemplates {
    
    let KeyboardBackgroundColor : String
    var KeysTextColorCharset1 : String
    var KeysTextColorCharset2 : String
    var KeysTextColorCharset3 : String
    var KeysColorCharset1 : String
    var KeysColorCharset2 : String
    var KeysColorCharset3 : String

    init (keyboardBackgroundColor : String, keysTextColor : String, keysTextColorCharset1: String, keysTextColorCharset2: String, keysTextColorCharset3: String,keysColorCharset1: String, keysColorCharset2: String, keysColorCharset3: String, RowOrCol : String) {
      
        KeyboardBackgroundColor = keyboardBackgroundColor
        KeysTextColorCharset1 = keysTextColorCharset1
        KeysTextColorCharset2 = keysTextColorCharset2
        KeysTextColorCharset3 = keysTextColorCharset3
        KeysColorCharset1 = keysColorCharset1
        KeysColorCharset2 = keysColorCharset2
        KeysColorCharset3 = keysColorCharset3
    }
}