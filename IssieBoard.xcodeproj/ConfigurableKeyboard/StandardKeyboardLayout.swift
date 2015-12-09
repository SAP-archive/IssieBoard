//
//  StandardLayout.swift
//  EducKeyboard
//
//  Created by Bezalel, Orit on 2/27/15.
//  Copyright (c) 2015 sap. All rights reserved.
//

import UIKit

// TODO: need to rename, consolidate, and define terms
class LayoutConstants: NSObject {
    class var landscapeRatio: CGFloat { get { return 2 }}
    
    // side edges increase on 6 in portrait
    class var sideEdgesPortraitArray: [CGFloat] { get { return [3, 4] }}
    class var sideEdgesPortraitWidthThreshholds: [CGFloat] { get { return [400] }}
    class var sideEdgesLandscape: CGFloat { get { return 3 }}
    
    // top edges decrease on various devices in portrait
    class var topEdgePortraitArray: [CGFloat] { get { return [12, 10, 8] }}
    class var topEdgePortraitWidthThreshholds: [CGFloat] { get { return [350, 400] }}
    class var topEdgeLandscape: CGFloat { get { return 6 }}
    
    // keyboard area shrinks in size in landscape on 6 and 6+
    class var keyboardShrunkSizeArray: [CGFloat] { get { return [522, 524] }}
    class var keyboardShrunkSizeWidthThreshholds: [CGFloat] { get { return [700] }}
    class var keyboardShrunkSizeBaseWidthThreshhold: CGFloat { get { return 600 }}
    
    // row gaps are weird on 6 in portrait
    class var rowGapPortraitArray: [CGFloat] { get { return [15, 11, 10] }}
    class var rowGapPortraitThreshholds: [CGFloat] { get { return [350, 400] }}
    class var rowGapPortraitLastRow: CGFloat { get { return 9 }}
    class var rowGapPortraitLastRowIndex: Int { get { return 1 }}
    class var rowGapLandscape: CGFloat { get { return 7 }}
    
    // key gaps have weird and inconsistent rules
    class var keyGapPortraitNormal: CGFloat { get { return 7 }}
    class var keyGapPortraitSmall: CGFloat { get { return 6 }}
    class var keyGapPortraitNormalThreshhold: CGFloat { get { return 350 }}
    class var keyGapPortraitUncompressThreshhold: CGFloat { get { return 350 }}
    class var keyGapLandscapeNormal: CGFloat { get { return 12 }}
    class var keyGapLandscapeSmall: CGFloat { get { return 11 }}
    // TODO: 5.5 row gap on 5L
    // TODO: wider row gap on 6L
    class var keyCompressedThreshhold: Int { get { return 11 }}
    
    // rows with two special keys on the side and characters in the middle (usually 3rd row)
    // TODO: these are not pixel-perfect, but should be correct within a few pixels
    // TODO: are there any "hidden constants" that would allow us to get rid of the multiplier? see: popup dimensions
    class var flexibleEndRowTotalWidthToKeyWidthMPortrait: CGFloat { get { return 1 }}
    class var flexibleEndRowTotalWidthToKeyWidthCPortrait: CGFloat { get { return -14 }}
    class var flexibleEndRowTotalWidthToKeyWidthMLandscape: CGFloat { get { return 0.9231 }}
    class var flexibleEndRowTotalWidthToKeyWidthCLandscape: CGFloat { get { return -9.4615 }}
    class var flexibleEndRowMinimumStandardCharacterWidth: CGFloat { get { return 7 }}
    
    class var lastRowKeyGapPortrait: CGFloat { get { return 6 }}
    class var lastRowKeyGapLandscapeArray: [CGFloat] { get { return [8, 7, 5] }}
    class var lastRowKeyGapLandscapeWidthThreshholds: [CGFloat] { get { return [500, 700] }}
    
    // TODO: approxmiate, but close enough
    class var lastRowPortraitFirstTwoButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.24 }}
    class var lastRowLandscapeFirstTwoButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.19 }}
    class var lastRowPortraitLastButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.24 }}
    class var lastRowLandscapeLastButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.19 }}
    class var micButtonPortraitWidthRatioToOtherSpecialButtons: CGFloat { get { return 0.765 }}
    
    // TODO: not exactly precise
    class var popupGap: CGFloat { get { return 8 }}
    class var popupWidthIncrement: CGFloat { get { return 26 }}
    class var popupTotalHeightArray: [CGFloat] { get { return [102, 108] }}
    class var popupTotalHeightDeviceWidthThreshholds: [CGFloat] { get { return [350] }}
    
    class func sideEdgesPortrait(width: CGFloat) -> CGFloat {
        return self.findThreshhold(self.sideEdgesPortraitArray, threshholds: self.sideEdgesPortraitWidthThreshholds, measurement: width)
    }
    class func topEdgePortrait(width: CGFloat) -> CGFloat {
        return self.findThreshhold(self.topEdgePortraitArray, threshholds: self.topEdgePortraitWidthThreshholds, measurement: width)
    }
    class func rowGapPortrait(width: CGFloat) -> CGFloat {
        return self.findThreshhold(self.rowGapPortraitArray, threshholds: self.rowGapPortraitThreshholds, measurement: width)
    }
    
    class func rowGapPortraitLastRow(width: CGFloat) -> CGFloat {
        let index = self.findThreshholdIndex(self.rowGapPortraitThreshholds, measurement: width)
        if index == self.rowGapPortraitLastRowIndex {
            return self.rowGapPortraitLastRow
        }
        else {
            return self.rowGapPortraitArray[index]
        }
    }
    
    class func keyGapPortrait(width: CGFloat, rowCharacterCount: Int) -> CGFloat {
        let compressed = (rowCharacterCount >= self.keyCompressedThreshhold)
        if compressed {
            if width >= self.keyGapPortraitUncompressThreshhold {
                return self.keyGapPortraitNormal
            }
            else {
                return self.keyGapPortraitSmall
            }
        }
        else {
            return self.keyGapPortraitNormal
        }
    }
    
    class func keyGapLandscape(width: CGFloat, rowCharacterCount: Int) -> CGFloat {
        let compressed = (rowCharacterCount >= self.keyCompressedThreshhold)
        let shrunk = self.keyboardIsShrunk(width)
        if compressed || shrunk {
            return self.keyGapLandscapeSmall
        }
        else {
            return self.keyGapLandscapeNormal
        }
    }
    
    class func lastRowKeyGapLandscape(width: CGFloat) -> CGFloat {
        return self.findThreshhold(self.lastRowKeyGapLandscapeArray, threshholds: self.lastRowKeyGapLandscapeWidthThreshholds, measurement: width)
    }
    
    class func keyboardIsShrunk(width: CGFloat) -> Bool {
        let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        return (isPad ? false : width >= self.keyboardShrunkSizeBaseWidthThreshhold)
    }
    class func keyboardShrunkSize(width: CGFloat) -> CGFloat {
        let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        if isPad {
            return width
        }
        
        if width >= self.keyboardShrunkSizeBaseWidthThreshhold {
            return self.findThreshhold(self.keyboardShrunkSizeArray, threshholds: self.keyboardShrunkSizeWidthThreshholds, measurement: width)
        }
        else {
            return width
        }
    }
    
    class func popupTotalHeight(deviceWidth: CGFloat) -> CGFloat {
        return self.findThreshhold(self.popupTotalHeightArray, threshholds: self.popupTotalHeightDeviceWidthThreshholds, measurement: deviceWidth)
    }
    
    class func findThreshhold(elements: [CGFloat], threshholds: [CGFloat], measurement: CGFloat) -> CGFloat {
        assert(elements.count == threshholds.count + 1, "elements and threshholds do not match")
        return elements[self.findThreshholdIndex(threshholds, measurement: measurement)]
    }
    class func findThreshholdIndex(threshholds: [CGFloat], measurement: CGFloat) -> Int {
        for (i, threshhold) in enumerate(reverse(threshholds)) {
            if measurement >= threshhold {
                let actualIndex = threshholds.count - i
                return actualIndex
            }
        }
        return 0
    }
}

class GlobalColors: NSObject {
    
    //Default Settings
    class var defaultBackgroundColor : UIColor //= Settings.defaultBackgroundColor
        {
        get {return UIColor.whiteColor()}
        set {GlobalColors.defaultBackgroundColor = newValue}
    }
    
    class var defaultTextColor : UIColor {
        get {return UIColor.blackColor()}
        set {GlobalColors.defaultTextColor = newValue}
    }
    
    class var defaultKeyColor : UIColor {
        get {return UIColor(hue: 0, saturation: 0, brightness: 0.8, alpha: 1.0)}
        set {GlobalColors.defaultTextColor = newValue}
    }
    
    class var defaultBorderColor : UIColor {
        get { return UIColor.whiteColor()}
        set { GlobalColors.defaultKeyColor = newValue}
    }
    
    class var backspaceKeyColor : UIColor {
        get { return UIColor.redColor() }
        set { GlobalColors.backspaceKeyColor = newValue}
    }
    class var spaceKeyColor : UIColor {
        get { return GlobalColors.defaultKeyColor}
        set { GlobalColors.spaceKeyColor = newValue}
    }
    
    class var returnKeyColor : UIColor {
        get { return UIColor.greenColor()}
        set { GlobalColors.returnKeyColor = newValue}
    }
    
    class var changeModeKeyColor : UIColor {
        get { return GlobalColors.defaultKeyColor}
        set { GlobalColors.changeModeKeyColor = newValue}
    }
    
    //Settings for area One
    
    class var cutomCharSetOneKeyColor : UIColor {
        get { return UIColor.blueColor()}
        set { GlobalColors.cutomCharSetOneKeyColor = newValue}
    }
    
    class var cutomCharSetOneTextColor : UIColor {
        get { return UIColor.whiteColor()}//GlobalColors.defaultTextColor}
        set { GlobalColors.cutomCharSetOneTextColor = newValue}
    }
    
    class var cutomCharSetOneBorderColor : UIColor {
        get { return UIColor.yellowColor()}
        set { GlobalColors.cutomCharSetOneBorderColor = newValue}
        
    }
    //Settings for ares two
    class var cutomCharSetTwoKeyColor : UIColor {
        get { return UIColor.yellowColor()}
        set { GlobalColors.cutomCharSetTwoKeyColor = newValue}
    }
    
    class var cutomCharSetTwoTextColor : UIColor {
        get { return UIColor.blackColor()}
        set { GlobalColors.cutomCharSetTwoTextColor = newValue}
    }
    
    class var cutomCharSetTwoBorderColor : UIColor {
        get { return GlobalColors.defaultBorderColor}
        set { GlobalColors.cutomCharSetTwoBorderColor = newValue}
    }
    
    //Settings for area three
    class var cutomCharSetThreeKeyColor : UIColor {
        get { return UIColor.orangeColor()}
        set { GlobalColors.cutomCharSetThreeKeyColor = newValue}
    }
    
    class var cutomCharSetThreeTextColor : UIColor {
        get { return UIColor.whiteColor()}
        set { GlobalColors.cutomCharSetThreeTextColor = newValue}
    }
    
    class var cutomCharSetThreeBorderColor : UIColor {
        get { return GlobalColors.defaultBorderColor}
        set { GlobalColors.cutomCharSetThreeBorderColor = newValue}
    }
    
    //Settings for hidden keys
    class var hiddenKeyColor : UIColor {
        get  { return GlobalColors.defaultBackgroundColor}
    }
    
    class var keyFont  : UIFont {
        get { return UIFont(name: Settings.sharedInstance.Font, size: 55)! }
    }
}

//"darkShadowColor": UIColor(hue: (220/360.0), saturation: 0.04, brightness: 0.56, alpha: 1),
//"blueColor": UIColor(hue: (211/360.0), saturation: 1.0, brightness: 1.0, alpha: 1),
//"blueShadowColor": UIColor(hue: (216/360.0), saturation: 0.05, brightness: 0.43, alpha: 1),

extension CGRect: Hashable {
    public var hashValue: Int {
        get {
            return (origin.x.hashValue ^ origin.y.hashValue ^ size.width.hashValue ^ size.height.hashValue)
        }
    }
}

extension CGSize: Hashable {
    public var hashValue: Int {
        get {
            return (width.hashValue ^ height.hashValue)
        }
    }
}

// handles the layout for the keyboard, including key spacing and arrangement
class KeyboardLayout: NSObject, KeyboardKeyProtocol {
    
    class var shouldPoolKeys: Bool { get { return true }}
    var layoutConstants: LayoutConstants.Type
    var globalColors: GlobalColors.Type
    unowned var model: Keyboard
    unowned var superview: UIView
    var modelToView: [Key:KeyboardKey] = [:]
    var viewToModel: [KeyboardKey:Key] = [:]
    var keyPool: [KeyboardKey] = []
    var nonPooledMap: [String:KeyboardKey] = [:]
    var sizeToKeyMap: [CGSize:[KeyboardKey]] = [:]
    var shapePool: [String:Shape] = [:]
    var initialized: Bool
    
    required init(model: Keyboard, superview: UIView, layoutConstants: LayoutConstants.Type, globalColors: GlobalColors.Type) {
        self.layoutConstants = layoutConstants
        self.globalColors = globalColors
        self.initialized = false
        self.model = model
        self.superview = superview
    }
    
    // TODO: remove this method
    func initialize() {
        assert(!self.initialized, "already initialized")
        self.initialized = true
    }
    
    func viewForKey(model: Key) -> KeyboardKey? {
        return self.modelToView[model]
    }
    
    func keyForView(key: KeyboardKey) -> Key? {
        return self.viewToModel[key]
    }
    
    //////////////////////////////////////////////
    // CALL THESE FOR LAYOUT/APPEARANCE CHANGES //
    //////////////////////////////////////////////
    
    func layoutKeys(pageNum: Int) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        // pre-allocate all keys if no cache
        if !self.dynamicType.shouldPoolKeys {
            if self.keyPool.isEmpty {
                for p in 0..<self.model.pages.count {
                    self.positionKeys(p)
                }
                self.updateKeyAppearance()
                self.updateKeyCaps(true)
            }
        }
        
        self.positionKeys(pageNum)
        self.superview.backgroundColor = Settings.sharedInstance.defaultBackgroundColor
        
        // reset state
        for (p, page) in enumerate(self.model.pages) {
            for (_, row) in enumerate(page.rows) {
                for (_, key) in enumerate(row) {
                    if let keyView = self.modelToView[key] {
                        keyView.hidePopup()
                        keyView.highlighted = false
                        keyView.hidden = (p != pageNum)
                    }
                }
            }
        }
        
        if self.dynamicType.shouldPoolKeys {
            self.updateKeyAppearance()
            self.updateKeyCaps(true)
        }
        
        CATransaction.commit()
    }
    
    func positionKeys(pageNum: Int) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        let setupKey = { (view: KeyboardKey, model: Key, frame: CGRect) -> Void in
            view.frame = frame
            self.modelToView[model] = view
            self.viewToModel[view] = model
        }
        
        if var keyMap = self.generateKeyFrames(self.model, bounds: self.superview.bounds, page: pageNum) {
            if self.dynamicType.shouldPoolKeys {
                
                self.modelToView.removeAll(keepCapacity: true)
                self.viewToModel.removeAll(keepCapacity: true)
                self.resetKeyPool()
                var foundCachedKeys = [Key]()
                
                // pass 1: reuse any keys that match the required size
                for (key, frame) in keyMap {
                    if var keyView = self.pooledKey(key: key, model: self.model, frame: frame) {
                        foundCachedKeys.append(key)
                        setupKey(keyView, key, frame)
                    }
                }
                
                foundCachedKeys.map {
                    keyMap.removeValueForKey($0)
                }
                
                // pass 2: fill in the blanks
                for (key, frame) in keyMap {
                    var keyView = self.generateKey()
                    setupKey(keyView, key, frame)
                }
            }
            else {
                for (key, frame) in keyMap {
                    if var keyView = self.pooledKey(key: key, model: self.model, frame: frame) {
                        setupKey(keyView, key, frame)
                    }
                }
            }
        }
        
        CATransaction.commit()
    }
    
    func updateKeyAppearance() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        for (key, view) in self.modelToView {
            view.shape = nil
            
            if let imageKey = view as? ImageKey {
                imageKey.image = nil
            }
            self.setAppearanceForKey(view, model: key)
        }
        
        CATransaction.commit()
    }
    
    // on fullReset, we update the keys with shapes, images, etc. as if from scratch; otherwise, just update the text
    // WARNING: if key cache is disabled, DO NOT CALL WITH fullReset MORE THAN ONCE
    func updateKeyCaps(fullReset: Bool){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        //        if fullReset {
        //            for (_, key) in self.modelToView {
        //                key.shape = nil
        //
        //                if let imageKey = key as? ImageKey { // TODO:
        //                   imageKey.image = nil
        //                }
        //            }
        //        }
        //
        //        for (model, key) in self.modelToView {
        //            self.updateKeyCap(key, model: model, fullReset: fullReset)//, uppercase: uppercase, characterUppercase: characterUppercase, shiftState: shiftState)
        //        }
        
        CATransaction.commit()
    }
    
    func updateKeyCap(key: KeyboardKey, model: Key, fullReset: Bool) {
        
        //        if fullReset {
        //            // font size
        //            switch model.type {
        //            case
        //            Key.KeyType.ModeChange,
        //            Key.KeyType.Space,
        //            Key.KeyType.Return:
        //                key.label.font = UIFont(name: "trashimclm-bold", size:50)//boldSystemFontOfSize(40)// key.label.font.fontWithSize(22)//key.label.font.fontWithSize(16)
        //                //key.label.font = UIFont(name: "ankaclm-bold", size:50)//boldSystemFontOfSize(40)// key.label.font.fontWithSize(22)
        //                key.label.adjustsFontSizeToFitWidth = true
        //            default:
        //                key.label.font = UIFont(name: "trashimclm-bold", size:50)//boldSystemFontOfSize(40)// key.label.font.fontWithSize(22)
        //                //key.label.font = UIFont(name: "ankaclm-bold", size:50)//boldSystemFontOfSize(40)// key.label.font.fontWithSize(22)
        //
        //            }
        //
        //            // label inset
        //            switch model.type {
        //            case
        //            Key.KeyType.ModeChange:
        //                key.labelInset = 3
        //            default:
        //                key.labelInset = 0
        //            }
        //
        //            // shapes
        //            switch model.type {
        //                /* case Key.KeyType.Shift:
        //                if key.shape == nil {
        //                let shiftShape = self.getShape(ShiftShape)
        //                key.shape = shiftShape
        //                }*/
        //            case Key.KeyType.Backspace:
        //                if key.shape == nil {
        //                    let backspaceShape = self.getShape(BackspaceShape)
        //                    key.shape = backspaceShape
        //                }
        //            case Key.KeyType.KeyboardChange:
        //                if key.shape == nil {
        //                    let globeShape = self.getShape(GlobeShape)
        //                    key.shape = globeShape
        //                }
        //            default:
        //                break
        //            }
        //
        //            // images
        //            if model.type == Key.KeyType.Return {
        //                if let imageKey = key as? ImageKey {
        //                    if imageKey.image == nil {
        //                        var keyboardImage = UIImage(named: "ic_keyboard_return_48px-512")
        //                        var keyboardImageView = UIImageView(image: keyboardImage)
        //                        imageKey.image = keyboardImageView
        //                    }
        //                }
        //            }
        //
        //        }
        //
        //        /*  if model.type == Key.KeyType.Shift {
        //        if key.shape == nil {
        //        let shiftShape = self.getShape(ShiftShape)
        //        key.shape = shiftShape
        //        }
        //
        //        switch shiftState {
        //        case .Disabled:
        //        key.highlighted = false
        //        case .Enabled:
        //        key.highlighted = true
        //        case .Locked:
        //        key.highlighted = true
        //        }
        //
        //        (key.shape as? ShiftShape)?.withLock = (shiftState == .Locked)
        //        }
        //        */
        //        self.updateKeyTitle(key, model: model)//, uppercase: uppercase, characterUppercase: characterUppercase)
    }
    
    func updateKeyTitle(key: KeyboardKey, model: Key){
        //  if model.type == .Character {
        // if (model.hasTitle) {
        //        key.text = model.getKeyTitle()
        // }
        // }
        //else {
        //  key.text = model.keyCapForCase(uppercase)
        // }
    }
    
    ///////////////
    // END CALLS //
    ///////////////
    
    func setAppearanceForKey(key: KeyboardKey, model: Key) {
        key.text = model.getKeyTitle()
        key.label.font = self.globalColors.keyFont
        key.label.adjustsFontSizeToFitWidth = true
        
        // By Sections Strings //
        var customCharSetOne : String = "פםןףךלץתצ"
        var customCharSetTwo : String = "וטאחיעמנה"
        var customCharSetThree : String = "רקכגדשבסז,."
        
        var customTwoCharSetOne : String = "@&₪098'\""
        var customTwoCharSetTwo : String = "765;()?!"
        var customTwoCharSetThree : String = ".,4123-/:"
        
        var customThreeCharSetOne : String = "*+=$€£'•"
        var customThreeCharSetTwo : String = "?!~<>#%^"
        var customThreeCharSetThree : String = ",.[]{}_\\|"
        
        // By Row Strings //
        var customKeyboardOneRowOne : String = ",.קראטוןםפ"
        var customKeyboardOneRowTwo : String = "שדגכעיחלךף"
        var customKeyboardOneRowThree : String = "זסבהנמצתץ"
        
        var customKeyboardThreeRowOne : String = "[]{}#%^*+="
        var customKeyboardThreeRowTwo : String = "_\\|~<>$€£"
        var customKeyboardThreeRowThree : String = "?!'•,."
        
        var customKeyboardTwoRowOne : String = "1234567890"
        var customKeyboardTwoRowTwo : String = "-/:;()₪&@"
        var customKeyboardTwoRowThree : String = "?!'\",."
        
        var rowOrCol : String = Settings.sharedInstance.RowOrCol
        
        if(Settings.sharedInstance.SpecialKeys.rangeOfString(key.text) != nil)
        {
            model.type = Key.KeyType.SpecialKeys
        }
        else if (model.type != Key.KeyType.HiddenKey)
        {
            if(rowOrCol == "By Rows")
            {
                if(model.pageNum == 0)
                {
                    if customKeyboardOneRowOne.rangeOfString(key.text) != nil {
                        model.type = Key.KeyType.CustomCharSetOne
                    }
                    else if customKeyboardOneRowTwo.rangeOfString(key.text) != nil {
                        model.type = Key.KeyType.CustomCharSetTwo
                    }
                    else if customKeyboardOneRowThree.rangeOfString(key.text) != nil {
                        model.type = Key.KeyType.CustomCharSetThree
                    }
                }
                else if(model.pageNum == 1)
                {
                    if customKeyboardTwoRowOne.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetOne
                    }
                    else if customKeyboardTwoRowTwo.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetTwo
                    }
                    else if customKeyboardTwoRowThree.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetThree
                    }
                }
                else if(model.pageNum == 2)
                {
                    if customKeyboardThreeRowOne.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetOne
                    }
                    else if customKeyboardThreeRowTwo.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetTwo
                    }
                    else if customKeyboardThreeRowThree.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetThree
                    }
                }
            }
            else
            {
                if(model.pageNum == 0)
                {
                    if customCharSetOne.rangeOfString(key.text) != nil {
                        model.type = Key.KeyType.CustomCharSetOne
                    }
                    else if customCharSetTwo.rangeOfString(key.text) != nil {
                        model.type = Key.KeyType.CustomCharSetTwo
                    }
                    else if customCharSetThree.rangeOfString(key.text) != nil {
                        model.type = Key.KeyType.CustomCharSetThree
                    }
                }
                else if(model.pageNum == 1)
                {
                    if customTwoCharSetOne.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetOne
                    }
                    else if customTwoCharSetTwo.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetTwo
                    }
                    else if customTwoCharSetThree.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetThree
                    }
                }
                else if(model.pageNum == 2)
                {
                    if customThreeCharSetOne.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetOne
                    }
                    else if customThreeCharSetTwo.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetTwo
                    }
                    else if customThreeCharSetThree.rangeOfString(key.text) != nil{
                        model.type = Key.KeyType.CustomCharSetThree
                    }
                }
            }
        }
        
        switch model.type {
        case
        Key.KeyType.Character,
        Key.KeyType.Undo,
        Key.KeyType.Restore :
            key.color = self.globalColors.defaultKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = self.globalColors.defaultTextColor
        case
        Key.KeyType.CustomCharSetOne :
            key.color = Settings.sharedInstance.charsetKeysOneBackgroundColor
            key.borderColor = self.globalColors.cutomCharSetOneBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = Settings.sharedInstance.charsetTextKeysOneBackgroundColor
        case
        Key.KeyType.CustomCharSetTwo :
            key.color = Settings.sharedInstance.charsetKeysTwoBackgroundColor
            key.borderColor = self.globalColors.cutomCharSetTwoBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = Settings.sharedInstance.charsetTextKeysTwoBackgroundColor
        case
        Key.KeyType.CustomCharSetThree :
            key.color = Settings.sharedInstance.charsetKeysThreeBackgroundColor
            key.borderColor = self.globalColors.cutomCharSetThreeBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = Settings.sharedInstance.charsetTextKeysThreeBackgroundColor
        case
        Key.KeyType.Space :
            key.color = self.globalColors.spaceKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = self.globalColors.defaultTextColor
        case
        Key.KeyType.Backspace :
            key.color = self.globalColors.backspaceKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            if key.shape == nil {
                let backspaceShape = self.getShape(BackspaceShape)
                key.shape = backspaceShape
            }
            key.labelInset = 3
        case
        Key.KeyType.ModeChange :
            key.color = self.globalColors.changeModeKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            key.textColor = self.globalColors.defaultTextColor
        case
        Key.KeyType.KeyboardChange :
            key.color = self.globalColors.changeModeKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            if let imageKey = key as? ImageKey {
                if imageKey.image == nil {
                    var keyboardImage = UIImage(named: "globe-512")
                    var keyboardImageView = UIImageView(image: keyboardImage)
                    imageKey.setImageSizeToScaleGC(30)
                    imageKey.image = keyboardImageView
                }
            }
        case
        Key.KeyType.DismissKeyboard:
            key.color = self.globalColors.changeModeKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            if let imageKey = key as? ImageKey {
                if imageKey.image == nil {
                    var keyboardImage = UIImage(named: "ic_keyboard_hide_48px-512")
                    var keyboardImageView = UIImageView(image: keyboardImage)
                    imageKey.setImageSizeToScaleGC(40)
                    imageKey.image = keyboardImageView
                    
                }
            }
        case
        Key.KeyType.Return :
            key.color = self.globalColors.returnKeyColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            key.textColor = self.globalColors.defaultTextColor
            if let imageKey = key as? ImageKey {
                if imageKey.image == nil {
                    var keyboardImage = UIImage(named: "ic_keyboard_return_48px-512")
                    var keyboardImageView = UIImageView(image: keyboardImage)
                    imageKey.setImageSizeToScaleGC(60)
                    imageKey.image = keyboardImageView
                }
            }
        case
        Key.KeyType.HiddenKey :
            key.color = Settings.sharedInstance.defaultBackgroundColor
            key.textColor = Settings.sharedInstance.defaultBackgroundColor
            key.borderColor = Settings.sharedInstance.defaultBackgroundColor
            key.hidden = true;
            key.downColor = nil
        case
        Key.KeyType.SpecialKeys :
            key.color = Settings.sharedInstance.SpecialKeyColor
            key.textColor = Settings.sharedInstance.SpecialKeyTextColor
            key.borderColor = Settings.sharedInstance.defaultBackgroundColor
            key.downColor = nil
        default:
            break
        }
    }
    
    func stam() {
        /*  Key.KeyType.Character,
        //Key.KeyType.Period,
        Key.KeyType.SofitLetter:
        //Key.KeyType.Space:
        key.color = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        if (model.type == Key.KeyType.SofitLetter) {
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorSofitCharacterKey : self.globalColors.lightModeTextColorSofitCharacterKey)
        }
        else {
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorCharacterKey : self.globalColors.lightModeTextColorCharacterKey)
        }
        key.downTextColor = nil
        case
        Key.KeyType.SpecialCharacter:
        // Key.KeyType.CtrlZ,
        //Key.KeyType.AltCtrlZ:
        key.color = self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        key.textColor = darkMode ? self.globalColors.darkModeTextColorSpecialCharacterKey : self.globalColors.lightModeTextColorSpecialCharacterKey
        key.downTextColor = nil
        /*case
        Key.KeyType.Shift:
        key.color = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        key.downColor = (darkMode ? self.globalColors.darkModeShiftKeyDown : self.globalColors.lightModeRegularKey)
        key.textColor = self.globalColors.darkModeTextColor
        key.downTextColor = self.globalColors.lightModeTextColor*/
        case Key.KeyType.Space:
        if(model.getPage() == 0) {
        key.color = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorCharacterKey : self.globalColors.lightModeTextColorCharacterKey)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        else {
        key.color = self.self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorSpecialCharacterKey : self.globalColors.lightModeTextColorSpecialCharacterKey)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        key.downTextColor = nil
        case Key.KeyType.Backspace:
        key.color = UIColor.redColor()
        if(model.getPage() == 0) {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        else {
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        key.downTextColor = nil
        // key.label.increaseSize(key)
        //UIColor.redColor().colorWithAlphaComponent(CGFloat(0.3))
        //key.textColor = self.globalColors.darkModeTextColor
        //Orit to add : key.downTextColor = (darkMode ? nil : self.globalColors.lightModeTextColor)
        case Key.KeyType.Return:
        key.color = UIColor.greenColor()
        if(model.getPage() == 0) {
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorCharacterKey : self.globalColors.lightModeTextColorCharacterKey)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        else {
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorSpecialCharacterKey : self.globalColors.lightModeTextColorSpecialCharacterKey)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        key.downTextColor = nil
        
        //key.downColor = UIColor.greenColor().colorWithAlphaComponent(CGFloat(0.3))
        //Orit : to check whether we need tot change label color
        //key.textColor = self.globalColors.darkModeTextColor
        //key.downTextColor = (darkMode ? nil : self.globalColors.lightModeTextColor)
        case
        Key.KeyType.ModeChange,
        Key.KeyType.KeyboardChange,
        Key.KeyType.DismissKeyboard:
        if (model.getPage() == 0) {
        key.color = UIColor.grayColor()//self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorCharacterKey : self.globalColors.lightModeTextColorCharacterKey)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        else {
        key.color = UIColor.yellowColor()//self.globalColors.getColorForSpecialCharacterKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = (darkMode ? self.globalColors.darkModeTextColorSpecialCharacterKey : self.globalColors.lightModeTextColorSpecialCharacterKey)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.getColorForCharacterKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        }
        key.downColor = nil
        
        func __setAppearanceForKey(key: KeyboardKey, model: Key, darkMode: Bool, solidColorMode: Bool) {
        if model.type == Key.KeyType.Other {
        self.setAppearanceForOtherKey(key, model: model, darkMode: darkMode, solidColorMode: solidColorMode)
        }
        
        switch model.type {
        case
        Key.KeyType.Character,
        Key.KeyType.SpecialCharacter,
        Key.KeyType.Period:
        key.color = self.self.globalColors.regularKey(darkMode, solidColorMode: solidColorMode)
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
        key.downColor = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        }
        else {
        key.downColor = nil
        }
        key.textColor = (darkMode ? self.globalColors.darkModeTextColor : self.globalColors.lightModeTextColor)
        key.downTextColor = nil
        case
        Key.KeyType.Space:
        key.color = self.globalColors.regularKey(darkMode, solidColorMode: solidColorMode)
        key.downColor = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = (darkMode ? self.globalColors.darkModeTextColor : self.globalColors.lightModeTextColor)
        key.downTextColor = nil
        case
        Key.KeyType.Shift:
        key.color = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        key.downColor = (darkMode ? self.globalColors.darkModeShiftKeyDown : self.globalColors.lightModeRegularKey)
        key.textColor = self.globalColors.darkModeTextColor
        key.downTextColor = self.globalColors.lightModeTextColor
        case
        Key.KeyType.Backspace:
        key.color = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        // TODO: actually a bit different
        key.downColor = self.globalColors.regularKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = self.globalColors.darkModeTextColor
        key.downTextColor = (darkMode ? nil : self.globalColors.lightModeTextColor)
        case
        Key.KeyType.ModeChange:
        key.color = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        key.downColor = nil
        key.textColor = (darkMode ? self.globalColors.darkModeTextColor : self.globalColors.lightModeTextColor)
        key.downTextColor = nil
        case
        Key.KeyType.Return,
        Key.KeyType.KeyboardChange,
        Key.KeyType.Settings:
        key.color = self.globalColors.specialKey(darkMode, solidColorMode: solidColorMode)
        // TODO: actually a bit different
        key.downColor = self.globalColors.regularKey(darkMode, solidColorMode: solidColorMode)
        key.textColor = (darkMode ? self.globalColors.darkModeTextColor : self.globalColors.lightModeTextColor)
        key.downTextColor = nil
        default:
        break
        }
        
        key.popupColor = self.globalColors.popup(darkMode, solidColorMode: solidColorMode)
        key.underColor = (self.darkMode ? self.globalColors.darkModeUnderColor : self.globalColors.lightModeUnderColor)
        key.borderColor = (self.darkMode ? self.globalColors.darkModeBorderColor : self.globalColors.lightModeBorderColor)
        }
        func setAppearanceForOtherKey(key: KeyboardKey, model: Key, darkMode: Bool, solidColorMode: Bool) { override this to handle special keys }
        */
    }
    
    ///////////////////////////
    // KEY POOLING FUNCTIONS //
    ///////////////////////////
    
    // if pool is disabled, always returns a unique key view for the corresponding key model
    func pooledKey(key aKey: Key, model: Keyboard, frame: CGRect) -> KeyboardKey? {
        if !self.dynamicType.shouldPoolKeys {
            var p: Int!
            var r: Int!
            var k: Int!
            
            // TODO: O(N^2) in terms of total # of keys since pooledKey is called for each key, but probably doesn't matter
            var foundKey: Bool = false
            for (pp, page) in enumerate(model.pages) {
                for (rr, row) in enumerate(page.rows) {
                    for (kk, key) in enumerate(row) {
                        if key == aKey {
                            p = pp
                            r = rr
                            k = kk
                            foundKey = true
                        }
                        if foundKey {
                            break
                        }
                    }
                    if foundKey {
                        break
                    }
                }
                if foundKey {
                    break
                }
            }
            
            let id = "p\(p)r\(r)k\(k)"
            if let key = self.nonPooledMap[id] {
                return key
            }
            else {
                let key = generateKey()
                self.nonPooledMap[id] = key
                return key
            }
        }
        else {
            if var keyArray = self.sizeToKeyMap[frame.size] {
                if let key = keyArray.last {
                    if keyArray.count == 1 {
                        self.sizeToKeyMap.removeValueForKey(frame.size)
                    }
                    else {
                        keyArray.removeLast()
                        self.sizeToKeyMap[frame.size] = keyArray
                    }
                    return key
                }
                else {
                    return nil
                }
                
            }
            else {
                return nil
            }
        }
    }
    
    func createNewKey() -> KeyboardKey {
        return ImageKey(vibrancy: nil)
    }
    
    // if pool is disabled, always generates a new key
    func generateKey() -> KeyboardKey {
        let createAndSetupNewKey = { () -> KeyboardKey in
            var keyView = self.createNewKey()
            keyView.enabled = true
            keyView.delegate = self
            self.superview.addSubview(keyView)
            self.keyPool.append(keyView)
            return keyView
        }
        
        if self.dynamicType.shouldPoolKeys {
            if !self.sizeToKeyMap.isEmpty {
                var (size, keyArray) = self.sizeToKeyMap[self.sizeToKeyMap.startIndex]
                
                if let key = keyArray.last {
                    if keyArray.count == 1 {
                        self.sizeToKeyMap.removeValueForKey(size)
                    }
                    else {
                        keyArray.removeLast()
                        self.sizeToKeyMap[size] = keyArray
                    }
                    
                    return key
                }
                else {
                    return createAndSetupNewKey()
                }
            }
            else {
                return createAndSetupNewKey()
            }
        }
        else {
            return createAndSetupNewKey()
        }
    }
    
    // if pool is disabled, doesn't do anything
    func resetKeyPool() {
        if self.dynamicType.shouldPoolKeys {
            self.sizeToKeyMap.removeAll(keepCapacity: true)
            
            for key in self.keyPool {
                if var keyArray = self.sizeToKeyMap[key.frame.size] {
                    keyArray.append(key)
                    self.sizeToKeyMap[key.frame.size] = keyArray
                }
                else {
                    var keyArray = [KeyboardKey]()
                    keyArray.append(key)
                    self.sizeToKeyMap[key.frame.size] = keyArray
                }
                key.hidden = true
            }
        }
    }
    
    // if pool disabled, always returns new shape
    func getShape(shapeClass: Shape.Type) -> Shape {
        let className = NSStringFromClass(shapeClass)
        
        if self.dynamicType.shouldPoolKeys {
            if let shape = self.shapePool[className] {
                return shape
            }
            else {
                var shape = shapeClass(frame: CGRectZero)
                self.shapePool[className] = shape
                return shape
            }
        }
        else {
            return shapeClass(frame: CGRectZero)
        }
    }
    
    //////////////////////
    // LAYOUT FUNCTIONS //
    //////////////////////
    
    func rounded(measurement: CGFloat) -> CGFloat {
        return round(measurement * UIScreen.mainScreen().scale) / UIScreen.mainScreen().scale
    }
    
    func generateKeyFrames(model: Keyboard, bounds: CGRect, page pageToLayout: Int) -> [Key:CGRect]? {
        if bounds.height == 0 || bounds.width == 0 {
            return nil
        }
        
        var keyMap = [Key:CGRect]()
        
        let isLandscape: Bool = {
            let boundsRatio = bounds.width / bounds.height
            return (boundsRatio >= self.layoutConstants.landscapeRatio)
            }()
        
        var sideEdges = (isLandscape ? self.layoutConstants.sideEdgesLandscape : self.layoutConstants.sideEdgesPortrait(bounds.width))
        let bottomEdge = sideEdges
        
        let normalKeyboardSize = bounds.width - CGFloat(2) * sideEdges
        let shrunkKeyboardSize = self.layoutConstants.keyboardShrunkSize(normalKeyboardSize)
        
        sideEdges += ((normalKeyboardSize - shrunkKeyboardSize) / CGFloat(2))
        
        let topEdge: CGFloat = (isLandscape ? self.layoutConstants.topEdgeLandscape : self.layoutConstants.topEdgePortrait(bounds.width))
        
        let rowGap: CGFloat = (isLandscape ? self.layoutConstants.rowGapLandscape : self.layoutConstants.rowGapPortrait(bounds.width))
        let lastRowGap: CGFloat = (isLandscape ? rowGap : self.layoutConstants.rowGapPortraitLastRow(bounds.width))
        
        let flexibleEndRowM = (isLandscape ? self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthMLandscape : self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthMPortrait)
        let flexibleEndRowC = (isLandscape ? self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthCLandscape : self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthCPortrait)
        
        let lastRowLeftSideRatio = (isLandscape ? self.layoutConstants.lastRowLandscapeFirstTwoButtonAreaWidthToKeyboardAreaWidth : self.layoutConstants.lastRowPortraitFirstTwoButtonAreaWidthToKeyboardAreaWidth)
        let lastRowRightSideRatio = (isLandscape ? self.layoutConstants.lastRowLandscapeLastButtonAreaWidthToKeyboardAreaWidth : self.layoutConstants.lastRowPortraitLastButtonAreaWidthToKeyboardAreaWidth)
        let lastRowKeyGap = (isLandscape ? self.layoutConstants.lastRowKeyGapLandscape(bounds.width) : self.layoutConstants.lastRowKeyGapPortrait)
        
        for (p, page) in enumerate(model.pages) {
            
            if p != pageToLayout {
                continue
            }
            
            let numRows = page.rows.count
            
            let mostKeysInRow: Int = {
                var currentMax: Int = 0
                for (i, row) in enumerate(page.rows) {
                    currentMax = max(currentMax, row.count)
                }
                return currentMax
                }()
            
            let rowGapTotal = CGFloat(numRows - 1 - 1) * rowGap + lastRowGap
            
            let keyGap: CGFloat = (isLandscape ? self.layoutConstants.keyGapLandscape(bounds.width, rowCharacterCount: mostKeysInRow) : self.layoutConstants.keyGapPortrait(bounds.width, rowCharacterCount: mostKeysInRow))
            
            let keyHeight: CGFloat = {
                let totalGaps = bottomEdge + topEdge + rowGapTotal
                var returnHeight = (bounds.height - totalGaps) / CGFloat(numRows)
                return self.rounded(returnHeight)
                }()
            
            let letterKeyWidth: CGFloat = {
                let totalGaps = (sideEdges * CGFloat(2)) + (keyGap * CGFloat(mostKeysInRow - 1))
                var returnWidth = (bounds.width - totalGaps) / CGFloat(mostKeysInRow)
                return self.rounded(returnWidth)
                }()
            
            let processRow = { (row: [Key], frames: [CGRect], inout map: [Key:CGRect]) -> Void in
                assert(row.count == frames.count, "row and frames don't match")
                for (k, key) in enumerate(row) {
                    map[key] = frames[k]
                }
            }
            
            for (r, row) in enumerate(page.rows) {
                let rowGapCurrentTotal = (r == page.rows.count - 1 ? rowGapTotal : CGFloat(r) * rowGap)
                let frame = CGRectMake(rounded(sideEdges), rounded(topEdge + (CGFloat(r) * keyHeight) + rowGapCurrentTotal), rounded(bounds.width - CGFloat(2) * sideEdges), rounded(keyHeight))
                
                var frames: [CGRect]!
                
                // basic character row: only typable characters
                if self.characterRowHeuristic(row) {
                    frames = self.layoutCharacterRow(row, keyWidth: letterKeyWidth, gapWidth: keyGap, frame: frame)
                }
                else if self.oneLeftSidedRowHeuristic(row) {
                    frames = self.layoutCharacterWithOneSideRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
                }
                    // character row with side buttons: change mode etc
                else if self.doubleLeftSidedOneRightSidedRowHeuristic(row) {
                    frames = self.layoutCharacterWithAsymetricSidesRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
                }
                    // bottom row with  space
                else {
                    frames = layoutCharacterWithSymetricSidesRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
                    //self.layoutSpecialKeysRow(row, keyWidth: letterKeyWidth, gapWidth: lastRowKeyGap, leftSideRatio: lastRowLeftSideRatio, rightSideRatio: lastRowRightSideRatio, micButtonRatio: self.layoutConstants.micButtonPortraitWidthRatioToOtherSpecialButtons, isLandscape: isLandscape, frame: frame)
                }
                
                processRow(row, frames, &keyMap)
            }
        }
        
        return keyMap
    }
    
    func characterRowHeuristic(row: [Key]) -> Bool {
        return (row.count >= 1 && row[0].isCharacter && row[row.count-1].isCharacter)
    }
    
    func doubleLeftSidedOneRightSidedRowHeuristic(row: [Key]) -> Bool {
        return (row.count >= 3 && !row[0].isCharacter && !row[1].isCharacter && !row[row.count-1].isCharacter && row[row.count-2].isCharacter)
    }
    
    func oneLeftSidedRowHeuristic(row: [Key]) -> Bool {
        return (row.count >= 3 && row[0].isCharacter && !row[row.count-1].isCharacter)
    }
    
    func layoutCharacterRow(row: [Key], keyWidth: CGFloat, gapWidth: CGFloat, frame: CGRect) -> [CGRect] {
        var frames = [CGRect]()
        let keySpace = CGFloat(row.count) * keyWidth + CGFloat(row.count - 1) * gapWidth
        var actualGapWidth = gapWidth
        var sideSpace = (frame.width - keySpace) / CGFloat(2)
        
        // TODO: port this to the other layout functions
        // avoiding rounding errors
        if sideSpace < 0 {
            sideSpace = 0
            actualGapWidth = (frame.width - (CGFloat(row.count) * keyWidth)) / CGFloat(row.count - 1)
        }
        
        if sideSpace > keyWidth/CGFloat(2) {
            sideSpace = keyWidth/CGFloat(3)
        }
        
        var currentOrigin = frame.origin.x + sideSpace
        
        for (k, key) in enumerate(row) {
            let roundedOrigin = rounded(currentOrigin)
            
            // avoiding rounding errors
            if roundedOrigin + keyWidth > frame.origin.x + frame.width {
                frames.append(CGRectMake(rounded(frame.origin.x + frame.width - keyWidth), frame.origin.y, keyWidth, frame.height))
            }
            else {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
            }
            
            currentOrigin += (keyWidth + actualGapWidth)
        }
        
        return frames
    }
    
    func layoutCharacterWithAsymetricSidesRow(row: [Key], frame: CGRect, isLandscape: Bool, keyWidth: CGFloat, keyGap: CGFloat) -> [CGRect] {
        var frames = [CGRect]()
        
        let keySpace = CGFloat(row.count) * keyWidth + CGFloat(row.count - 1) * keyGap
        var actualGapWidth = keyGap
        
        var sideSpace = (frame.width - keySpace) / CGFloat(2)
        
        if sideSpace > keyWidth/CGFloat(2) {
            sideSpace = keyWidth/CGFloat(3)
        }
        
        var currentOrigin = frame.origin.x
        
        for (k, key) in enumerate(row) {
            if k == 1 {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, CGFloat(1.8)*keyWidth, frame.height))
                currentOrigin += (CGFloat(1.8)*keyWidth + keyGap)
            }
            else if k == row.count - 1 {
                currentOrigin += (frame.width - currentOrigin - CGFloat(1.3)*keyWidth)
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y,(CGFloat(1.3)*keyWidth), frame.height))
                
            }
            else {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
                currentOrigin += (keyWidth + keyGap)
            }
        }
        
        return frames
    }
    
    func layoutCharacterWithSymetricSidesRow(row: [Key], frame: CGRect, isLandscape: Bool, keyWidth: CGFloat, keyGap: CGFloat) -> [CGRect] {
        var frames = [CGRect]()
        
        var sizeSpaceKey = CGFloat(6)*keyWidth + CGFloat(5)*keyGap
        var sizeForAllSpecialKeys = (frame.width - sizeSpaceKey - keyWidth - (CGFloat(4)*keyGap))
        var sizeOfSpecialKeyExceptOne = sizeForAllSpecialKeys/CGFloat(3)
        
        var currentOrigin = frame.origin.x
        
        frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, sizeOfSpecialKeyExceptOne, frame.height))
        currentOrigin += (sizeOfSpecialKeyExceptOne + keyGap)
        
        frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, sizeOfSpecialKeyExceptOne, frame.height))
        currentOrigin += (sizeOfSpecialKeyExceptOne + keyGap)
        
        frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, sizeSpaceKey, frame.height))
        currentOrigin += (sizeSpaceKey + keyGap)
        
        frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, sizeOfSpecialKeyExceptOne, frame.height))
        currentOrigin += (sizeOfSpecialKeyExceptOne + keyGap)
        
        frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
        return frames
    }
    
    func layoutCharacterWithOneSideRow(row: [Key], frame: CGRect, isLandscape: Bool, keyWidth: CGFloat, keyGap: CGFloat) -> [CGRect] {
        var frames = [CGRect]()
        
        //        let standardFullKeyCount = Int(self.layoutConstants.keyCompressedThreshhold) - 1
        //        let standardGap = (isLandscape ? self.layoutConstants.keyGapLandscape : self.layoutConstants.keyGapPortrait)(frame.width, rowCharacterCount: standardFullKeyCount)
        //        let sideEdges = (isLandscape ? self.layoutConstants.sideEdgesLandscape : self.layoutConstants.sideEdgesPortrait(frame.width))
        //        var standardKeyWidth = (frame.width - sideEdges - (standardGap * CGFloat(standardFullKeyCount - 1)) - sideEdges)
        //        standardKeyWidth /= CGFloat(standardFullKeyCount)
        //        let standardKeyCount = self.layoutConstants.flexibleEndRowMinimumStandardCharacterWidth
        //
        //        let standardWidth = CGFloat(standardKeyWidth * standardKeyCount + standardGap * (standardKeyCount - 1))
        //        let currentWidth = CGFloat(row.count) * keyWidth + CGFloat(row.count - 1) * keyGap
        //
        //        let isStandardWidth = (currentWidth < standardWidth)
        //        let actualWidth = (isStandardWidth ? standardWidth : currentWidth)
        //        let actualGap = (isStandardWidth ? standardGap : keyGap)
        //        let actualKeyWidth = (actualWidth - CGFloat(row.count - 3) * actualGap) / CGFloat(row.count - 2)
        //
        
        
        let keySpace = CGFloat(row.count) * keyWidth + CGFloat(row.count - 1) * keyGap
        var actualGapWidth = keyGap
        var sideSpace = (frame.width - keySpace) / CGFloat(2)
        
        
        //var sideSpace = (frame.width - actualWidth) / CGFloat(2)
        
        if sideSpace > keyWidth/CGFloat(2) {
            sideSpace = keyWidth/CGFloat(2)
        }
        //
        //        let m = (isLandscape ? self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthMLandscape : self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthMPortrait)
        //        let c = (isLandscape ? self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthCLandscape : self.layoutConstants.flexibleEndRowTotalWidthToKeyWidthCPortrait)
        //
        //        var specialCharacterWidth = sideSpace * m + c
        //        specialCharacterWidth = max(specialCharacterWidth, keyWidth)
        //        specialCharacterWidth = rounded(specialCharacterWidth)
        //        let specialCharacterGap = sideSpace - specialCharacterWidth
        
        var currentOrigin = frame.origin.x + 1.5*sideSpace
        
        for (k, key) in enumerate(row) {
            if k == 0 {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
                currentOrigin += (keyWidth + keyGap)    //(specialCharacterWidth + specialCharacterGap)
            }
            else if k == row.count - 1 {
                // currentOrigin += specialCharacterGap
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, /*specialCharacterWidth*/(frame.width-currentOrigin), frame.height))
                //currentOrigin += specialCharacterWidth
            }
            else {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
                //                if k == row.count - 2 {
                //                    currentOrigin += (actualKeyWidth)
                //                }
                //                else {
                currentOrigin += (keyWidth + keyGap)
                // }
            }
        }
        
        return frames
    }
    
    func layoutSpecialKeysRow(row: [Key], keyWidth: CGFloat, gapWidth: CGFloat, leftSideRatio: CGFloat, rightSideRatio: CGFloat, micButtonRatio: CGFloat, isLandscape: Bool, frame: CGRect) -> [CGRect] {
        var frames = [CGRect]()
        
        var keysBeforeSpace = 0
        var keysAfterSpace = 0
        var reachedSpace = false
        for (k, key) in enumerate(row) {
            if key.type == Key.KeyType.Space {
                reachedSpace = true
            }
            else {
                if !reachedSpace {
                    keysBeforeSpace += 1
                }
                else {
                    keysAfterSpace += 1
                }
            }
        }
        
        // assert((keysBeforeSpace <= 3 && reachedSpace), "invalid number of keys before space (only max 3 currently supported)")
        // assert((keysAfterSpace <= 3 && reachedSpace), "invalid number of keys after space (only default 1 currently supported)")
        
        let hasButtonInMicButtonPosition = (keysBeforeSpace == 3)
        
        var leftSideAreaWidth = frame.width * leftSideRatio
        let rightSideAreaWidth = frame.width * rightSideRatio
        var leftButtonWidth = (leftSideAreaWidth - (gapWidth * CGFloat(2 - 1))) / CGFloat(2)
        leftButtonWidth = rounded(leftButtonWidth)
        var rightButtonWidth = (rightSideAreaWidth - (gapWidth * CGFloat(keysAfterSpace - 1))) / CGFloat(keysAfterSpace)
        rightButtonWidth = rounded(rightButtonWidth)
        
        let micButtonWidth = (isLandscape ? leftButtonWidth : leftButtonWidth * micButtonRatio)
        
        // special case for mic button
        if hasButtonInMicButtonPosition {
            leftSideAreaWidth = leftSideAreaWidth + gapWidth + micButtonWidth
        }
        
        var spaceWidth = frame.width - leftSideAreaWidth - rightSideAreaWidth - gapWidth * CGFloat(2)
        spaceWidth = rounded(spaceWidth)
        
        var currentOrigin = frame.origin.x
        var beforeSpace: Bool = true
        for (k, key) in enumerate(row) {
            if key.type == Key.KeyType.Space {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, spaceWidth, frame.height))
                currentOrigin += (spaceWidth + gapWidth)
                beforeSpace = false
            }
            else if beforeSpace {
                if hasButtonInMicButtonPosition && k == 2 { //mic button position
                    frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, micButtonWidth, frame.height))
                    currentOrigin += (micButtonWidth + gapWidth)
                }
                else {
                    frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, leftButtonWidth, frame.height))
                    currentOrigin += (leftButtonWidth + gapWidth)
                }
            }
            else {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, rightButtonWidth, frame.height))
                currentOrigin += (rightButtonWidth + gapWidth)
            }
        }
        
        return frames
    }
    
    ////////////////
    // END LAYOUT //
    ////////////////
    
    func frameForPopup(key: KeyboardKey, direction: Direction) -> CGRect {
        let actualScreenWidth = (UIScreen.mainScreen().nativeBounds.size.width / UIScreen.mainScreen().nativeScale)
        let totalHeight = self.layoutConstants.popupTotalHeight(actualScreenWidth)
        
        let popupWidth = key.bounds.width + self.layoutConstants.popupWidthIncrement
        let popupHeight = totalHeight - self.layoutConstants.popupGap - key.bounds.height
        let popupCenterY = 0
        
        return CGRectMake((key.bounds.width - popupWidth) / CGFloat(2), -popupHeight - self.layoutConstants.popupGap, popupWidth, popupHeight)
    }
    
    func willShowPopup(key: KeyboardKey, direction: Direction) {
        // TODO: actual numbers, not standins
        if let popup = key.popup {
            // TODO: total hack
            let actualSuperview = (self.superview.superview != nil ? self.superview.superview! : self.superview)
            
            var localFrame = actualSuperview.convertRect(popup.frame, fromView: popup.superview)
            
            if localFrame.origin.y < 3 {
                localFrame.origin.y = 3
                
                key.background.attached = Direction.Down
                key.connector?.startDir = Direction.Down
                key.background.hideDirectionIsOpposite = true
            }
            else {
                // TODO: this needs to be reset somewhere
                key.background.hideDirectionIsOpposite = false
            }
            
            if localFrame.origin.x < 3 {
                localFrame.origin.x = key.frame.origin.x
            }
            
            if localFrame.origin.x + localFrame.width > superview.bounds.width - 3 {
                localFrame.origin.x = key.frame.origin.x + key.frame.width - localFrame.width
            }
            
            popup.frame = actualSuperview.convertRect(localFrame, toView: popup.superview)
        }
    }
    
    func willHidePopup(key: KeyboardKey) {}
}