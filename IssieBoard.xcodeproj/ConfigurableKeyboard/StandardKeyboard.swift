//
//  KeyboardView.swift
//  EducKeyboard
//
//  Created by Bezalel, Orit on 2/27/15.
//  Copyright (c) 2015 sap. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    // Computed Properties
    
    var isEmptyOrWhiteSpace : Bool { return self.isEmpty || self.isWhiteSpace }
    var isWhiteSpace        : Bool { return !self.isEmpty && self.trim().isEmpty }
    
    // Methods
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

func standardKeyboard() -> Keyboard {
    
    var customCharSetOne : String = "פםןףךלץתצ"
    var customCharSetTwo : String = "וטאחיעמנה"
    var customCharSetThree : String = "רקכגדשבסז,."
       
    var visibleKeys : String = Settings.sharedInstance.visibleKeys
    
    if(visibleKeys.isEmptyOrWhiteSpace)
    {
        visibleKeys = Settings.sharedInstance.allCharsInKeyboard
    }
    
    var standardKeyboard = Keyboard()
    
    for key in [ ",", ".", "ק", "ר", "א", "ט", "ו", "ן", "ם", "פ"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }
        
        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(0)
        standardKeyboard.addKey(keyModel, row: 0, page: 0)
    }
    
    var backspace = Key(.Backspace)
    backspace.setPage(0)
    standardKeyboard.addKey(backspace, row: 0, page: 0)
    
    for key in ["ש", "ד", "ג", "כ", "ע", "י", "ח", "ל", "ך", "ף"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }
        
        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(0)
        standardKeyboard.addKey(keyModel, row: 1, page: 0)
    }
    
    
    for key in [ "ז", "ס", "ב", "ה", "נ", "מ", "צ", "ת", "ץ"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }
        
        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(0)
        standardKeyboard.addKey(keyModel, row: 2, page: 0)
    }
    
    var returnKey = Key(.Return)
    returnKey.setKeyOutput("\n")
    returnKey.setPage(0)
    standardKeyboard.addKey(returnKey, row: 1, page: 0)
    
    var keyModeChangeNumbers = Key(.ModeChange)
    keyModeChangeNumbers.setKeyTitle(".?123")
    keyModeChangeNumbers.toMode = 1
    keyModeChangeNumbers.setPage(0)
    standardKeyboard.addKey(keyModeChangeNumbers, row: 3, page: 0)
    
    var keyboardChange = Key(.KeyboardChange)
    keyboardChange.setPage(0)
    standardKeyboard.addKey(keyboardChange, row: 3, page: 0)
    
    
    var space = Key(.Space)
    space.setKeyTitle("רווח")
    space.setKeyOutput(" ")
    space.setPage(0)
    standardKeyboard.addKey(space, row: 3, page: 0)
    
    standardKeyboard.addKey(Key(keyModeChangeNumbers), row: 3, page: 0)
    
    var dismissKeyboard = Key(.DismissKeyboard)
    dismissKeyboard.setPage(0)
    standardKeyboard.addKey(dismissKeyboard, row: 3, page: 0)
    
    
    for key in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }
        
        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(1)
        standardKeyboard.addKey(keyModel, row: 0, page: 1)
    }
    
    backspace = Key(backspace)
    backspace.setPage(1)
    standardKeyboard.addKey(backspace, row: 0, page: 1)
    
    
    for key in ["-", "/", ":", ";", "(", ")","₪", "&", "@"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }
        
        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(1)
        standardKeyboard.addKey(keyModel, row: 1, page: 1)
    }
    
    returnKey = Key(returnKey)
    returnKey.setPage(1)
    standardKeyboard.addKey(returnKey, row: 1, page: 1)
    
    
    var keyModeChangeSpecialCharacters = Key(.ModeChange)
    keyModeChangeSpecialCharacters.setKeyTitle("#+=")
    keyModeChangeSpecialCharacters.toMode = 2
    keyModeChangeSpecialCharacters.setPage(1)
    standardKeyboard.addKey(keyModeChangeSpecialCharacters, row: 2, page: 1)
    //standardKeyboard.addKey(Key(keyModeChangeSpecialCharacters), row: 2, page: 1)

    
    var undoKey = Key(.Undo)
    undoKey.setKeyTitle("בטל")
    undoKey.setPage(1)
    standardKeyboard.addKey(undoKey, row: 2, page: 1)
    
    for key in [".", ",", "?", "!", "'", "\""] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }

        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(1)
        standardKeyboard.addKey(keyModel, row: 2, page: 1)
    }
    
    standardKeyboard.addKey(Key(keyModeChangeSpecialCharacters), row: 2, page: 1)
    
    var keyModeChangeLetters = Key(.ModeChange)
    keyModeChangeLetters.setKeyTitle("אבג")
    keyModeChangeLetters.toMode = 0
    keyModeChangeLetters.setPage(1)
    standardKeyboard.addKey(keyModeChangeLetters, row: 3, page: 1)
    
    keyboardChange = Key(keyboardChange)
    keyboardChange.setPage(1)
    standardKeyboard.addKey(keyboardChange, row: 3, page: 1)
    
    space = Key(space)
    space.setPage(1)
    standardKeyboard.addKey(space, row: 3, page: 1)
    
    standardKeyboard.addKey(Key(keyModeChangeLetters), row: 3, page: 1)
    
    //orit: add output
    dismissKeyboard = Key(dismissKeyboard)
    dismissKeyboard.setPage(1)
    standardKeyboard.addKey(dismissKeyboard, row: 3, page: 1)
    
    for key in ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }

        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(2)
        standardKeyboard.addKey(keyModel, row: 0, page: 2)
    }
    
    backspace = Key(backspace)
    backspace.setPage(2)
    standardKeyboard.addKey(backspace, row: 0, page: 2)
    
    for key in ["_", "\\", "|", "~", "<", ">", "$", "€", "£"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }

        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(2)
        standardKeyboard.addKey(keyModel, row: 1, page: 2)
    }
    
    returnKey = Key(returnKey)
    returnKey.setPage(2)
    standardKeyboard.addKey(returnKey, row: 1, page: 2)
    
    keyModeChangeNumbers = Key(keyModeChangeNumbers)
    keyModeChangeNumbers.setPage(2)
    standardKeyboard.addKey(keyModeChangeNumbers, row: 2, page: 2)
    
    var restoreKey = Key(.Restore)
    restoreKey.setKeyTitle("שחזר")
    restoreKey.setPage(2)
    standardKeyboard.addKey(restoreKey, row: 2, page: 2)
    
    
    for key in [".", ",", "?", "!", "'", "•"] {
        var keyModel : Key
        
        if (visibleKeys.rangeOfString(key) == nil) {
            keyModel = Key (.HiddenKey)
        }
        else if (customCharSetOne.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetOne)
        }
        else if (customCharSetTwo.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetTwo)
        }
        else if (customCharSetThree.rangeOfString(key) != nil) {
            keyModel = Key(.CustomCharSetThree)
        }
        else {
            keyModel = Key(.Character)
        }
        keyModel.setKeyTitle(key)
        keyModel.setKeyOutput(key)
        keyModel.setPage(2)
        standardKeyboard.addKey(keyModel, row: 2, page: 2)
    }
    
    standardKeyboard.addKey(Key(keyModeChangeNumbers), row: 2, page: 2)
    
    keyModeChangeLetters = Key(keyModeChangeLetters)
    keyModeChangeLetters.setPage(2)
    standardKeyboard.addKey(keyModeChangeLetters,row: 3, page: 2)
    
    keyboardChange = Key(keyboardChange)
    keyboardChange.setPage(2)
    standardKeyboard.addKey(keyboardChange, row: 3, page: 2)
    
    space = Key(space)
    space.setPage(2)
    standardKeyboard.addKey(space, row: 3, page: 2)
    
    standardKeyboard.addKey(Key(keyModeChangeLetters), row: 3, page: 2)
    
    dismissKeyboard = Key(dismissKeyboard)
    dismissKeyboard.setPage(2)
    standardKeyboard.addKey(Key(dismissKeyboard), row: 3, page: 2)
    
    return standardKeyboard
}
