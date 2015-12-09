//
//  KeyboardModel.swift
//  EducKeyboard
//
//  Created by Bezalel, Orit on 2/26/15.
//  Copyright (c) 2015 sap. All rights reserved.

import Foundation

var counter = 0

class Keyboard {
    var pages: [Page]
    
    init() {
        self.pages = []
    }
    
    func addKey(key: Key, row: Int, page: Int) {
        if self.pages.count <= page {
            for i in self.pages.count...page {
                self.pages.append(Page())
            }
        }
        
        self.pages[page].addKey(key, row: row)
    }
}

class Page {
    var rows: [[Key]]
    
    init() {
        self.rows = []
    }
    
    func addKey(key: Key, row: Int) {
        if self.rows.count <= row {
            for i in self.rows.count...row {
                self.rows.append([])
            }
        }
        
        self.rows[row].append(key)
    }
}

class Key: Hashable {
    enum KeyType {
        case Character
        case Backspace
        case ModeChange
        case KeyboardChange
        case Space
        case Return
        case Undo
        case Restore
        case DismissKeyboard
        case CustomCharSetOne
        case CustomCharSetTwo
        case CustomCharSetThree
        case SpecialKeys
        case HiddenKey
        case Other
    }
    
    var type: KeyType
    var keyTitle : String?
    var keyOutput : String?
    var pageNum: Int
    var toMode: Int? //if type is ModeChange toMode holds the page it links to
    var hasOutput : Bool {return (keyOutput != nil)}
    var hasTitle : Bool {return (keyTitle != nil)}
    
    
    var isCharacter: Bool {
        get {
            switch self.type {
            case
            .Character,
            .CustomCharSetOne,
            .CustomCharSetTwo,
            .CustomCharSetThree,
            .HiddenKey,
            .SpecialKeys:
                return true
            default:
                return false
            }
        }
    }
    
    var isSpecial: Bool {
        get {
            switch self.type {
            case
            .Backspace,
            .ModeChange,
            .KeyboardChange,
            .Space,
            .DismissKeyboard,
            .Return,
            .Undo,
            .Restore :
                return true
            default:
                return false
            }
        }
    }
    
    var hashValue: Int
    
    init(_ type: KeyType) {
        self.type = type
        self.hashValue = counter
        counter += 1
        pageNum = -1
    }
    
    convenience init(_ key: Key) {
        self.init(key.type)
        self.keyTitle = key.keyTitle
        self.keyOutput = key.keyOutput
        self.toMode = key.toMode
        self.pageNum = key.getPage()
    }
    
    func setKeyTitle(keyTitle: String) {
        self.keyTitle = keyTitle
    }
    
    func getKeyTitle () -> String {
        if (keyTitle != nil) {
            return keyTitle!
        }
        else {
            return ""
        }
    }
    
    func setKeyOutput(keyOutput: String) {
        self.keyOutput = keyOutput
    }
    
    func getKeyOutput () -> String {
        if (keyOutput != nil) {
            return keyOutput!
        }
        else {
            return ""
        }
    }
    
    func setPage(pageNum : Int) {
        self.pageNum = pageNum
    }
    
    func getPage() -> Int {
        return self.pageNum
    }
    
}

func ==(lhs: Key, rhs: Key) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
