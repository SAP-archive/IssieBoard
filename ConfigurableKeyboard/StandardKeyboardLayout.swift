

import Foundation
import UIKit

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
    class var keyCompressedThreshhold: Int { get { return 11 }}
    
    class var flexibleEndRowTotalWidthToKeyWidthMPortrait: CGFloat { get { return 1 }}
    class var flexibleEndRowTotalWidthToKeyWidthCPortrait: CGFloat { get { return -14 }}
    class var flexibleEndRowTotalWidthToKeyWidthMLandscape: CGFloat { get { return 0.9231 }}
    class var flexibleEndRowTotalWidthToKeyWidthCLandscape: CGFloat { get { return -9.4615 }}
    class var flexibleEndRowMinimumStandardCharacterWidth: CGFloat { get { return 7 }}
    
    class var lastRowKeyGapPortrait: CGFloat { get { return 6 }}
    class var lastRowKeyGapLandscapeArray: [CGFloat] { get { return [8, 7, 5] }}
    class var lastRowKeyGapLandscapeWidthThreshholds: [CGFloat] { get { return [500, 700] }}
    
    class var lastRowPortraitFirstTwoButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.24 }}
    class var lastRowLandscapeFirstTwoButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.19 }}
    class var lastRowPortraitLastButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.24 }}
    class var lastRowLandscapeLastButtonAreaWidthToKeyboardAreaWidth: CGFloat { get { return 0.19 }}
    class var micButtonPortraitWidthRatioToOtherSpecialButtons: CGFloat { get { return 0.765 }}
    
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
        for (i, threshhold) in Array(threshholds.reverse()).enumerate() {
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
    class var defaultBackgroundColor : UIColor
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
        get { return UIColor.whiteColor()}
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
    
    func layoutKeys(pageNum: Int) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
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
        self.superview.backgroundColor = Settings.sharedInstance.GetBackgroundColorByTemplate()
        
        for (p, page) in self.model.pages.enumerate() {
            for (_, row) in page.rows.enumerate() {
                for (_, key) in row.enumerate() {
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
                
                for (key, frame) in keyMap {
                    if let keyView = self.pooledKey(key: key, model: self.model, frame: frame) {
                        foundCachedKeys.append(key)
                        setupKey(keyView, key, frame)
                    }
                }
                
                foundCachedKeys.map {
                    keyMap.removeValueForKey($0)
                }
                
                for (key, frame) in keyMap {
                    let keyView = self.generateKey()
                    setupKey(keyView, key, frame)
                }
            }
            else {
                for (key, frame) in keyMap {
                    if let keyView = self.pooledKey(key: key, model: self.model, frame: frame) {
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
    
    func updateKeyCaps(fullReset: Bool){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.commit()
    }
    
    func setAppearanceForKey(key: KeyboardKey, model: Key) {
        key.text = model.getKeyTitle()
        key.label.font = self.globalColors.keyFont
        key.label.adjustsFontSizeToFitWidth = true
        
        // Settings - By Sections Strings //
        let customCharSetOne : String = "פםןףךלץתצ"
        let customCharSetTwo : String = "וטאחיעמנה"
        let customCharSetThree : String = "רקכגדשבסז,."
        
        let customTwoCharSetOne : String = "@&₪098'\""
        let customTwoCharSetTwo : String = "765;()?!"
        let customTwoCharSetThree : String = ".,4123-/:"
        
        let customThreeCharSetOne : String = "*+=$€£'•"
        let customThreeCharSetTwo : String = "?!~<>#%^"
        let customThreeCharSetThree : String = ",.[]{}_\\|"
        
        // Settings - By Row Strings //
        let customKeyboardOneRowOne : String = ",.קראטוןםפ"
        let customKeyboardOneRowTwo : String = "שדגכעיחלךף"
        let customKeyboardOneRowThree : String = "זסבהנמצתץ"
        
        let customKeyboardThreeRowOne : String = "[]{}#%^*+="
        let customKeyboardThreeRowTwo : String = "_\\|~<>$€£"
        let customKeyboardThreeRowThree : String = "?!'•,."
        
        let customKeyboardTwoRowOne : String = "1234567890"
        let customKeyboardTwoRowTwo : String = "-/:;()₪&@"
        let customKeyboardTwoRowThree : String = "?!'\",."
        
        let rowOrCol : String = Settings.sharedInstance.RowOrCol
        
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
            key.color = Settings.sharedInstance.OtherKeysColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = self.globalColors.defaultTextColor
        case
        Key.KeyType.CustomCharSetOne :
            key.color = Settings.sharedInstance.GetKeyColorByTemplate(model)
            key.borderColor = self.globalColors.cutomCharSetOneBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = Settings.sharedInstance.GetKeyTextColorByTemplate(model)
        case
        Key.KeyType.CustomCharSetTwo :
            key.color = Settings.sharedInstance.GetKeyColorByTemplate(model)
            key.borderColor = self.globalColors.cutomCharSetTwoBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = Settings.sharedInstance.GetKeyTextColorByTemplate(model)
        case
        Key.KeyType.CustomCharSetThree :
            key.color = Settings.sharedInstance.GetKeyColorByTemplate(model)
            key.borderColor = self.globalColors.cutomCharSetThreeBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = Settings.sharedInstance.GetKeyTextColorByTemplate(model)
        case
        Key.KeyType.Space :
            key.color = Settings.sharedInstance.SpaceColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.changeModeKeyColor
            key.downTextColor = nil
            key.textColor = self.globalColors.defaultTextColor
        case
        Key.KeyType.Backspace :
            key.color = Settings.sharedInstance.BackspaceColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            if key.shape == nil {
                let backspaceShape = self.getShape(BackspaceShape)
                key.shape = backspaceShape
            }
            key.labelInset = 3
        case
        Key.KeyType.ModeChange :
            key.color = Settings.sharedInstance.OtherKeysColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            key.textColor = self.globalColors.defaultTextColor
        case
        Key.KeyType.KeyboardChange :
            key.color = Settings.sharedInstance.OtherKeysColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            if let imageKey = key as? ImageKey {
                if imageKey.image == nil {
                    let keyboardImage = UIImage(named: "globe-512")
                    let keyboardImageView = UIImageView(image: keyboardImage)
                    imageKey.setImageSizeToScaleGC(30)
                    imageKey.image = keyboardImageView
                }
            }
        case
        Key.KeyType.DismissKeyboard:
            key.color = Settings.sharedInstance.OtherKeysColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            if let imageKey = key as? ImageKey {
                if imageKey.image == nil {
                    let keyboardImage = UIImage(named: "ic_keyboard_hide_48px-512")
                    let keyboardImageView = UIImageView(image: keyboardImage)
                    imageKey.setImageSizeToScaleGC(40)
                    imageKey.image = keyboardImageView
                }
            }
        case
        Key.KeyType.Return :
            key.color = Settings.sharedInstance.EnterColor
            key.borderColor = self.globalColors.defaultBorderColor
            key.downColor = self.globalColors.defaultKeyColor
            key.textColor = self.globalColors.defaultTextColor
            if let imageKey = key as? ImageKey {
                if imageKey.image == nil {
                    let keyboardImage = UIImage(named: "ic_keyboard_return_48px-512")
                    let keyboardImageView = UIImageView(image: keyboardImage)
                    imageKey.setImageSizeToScaleGC(60)
                    imageKey.image = keyboardImageView
                }
            }
        case
        Key.KeyType.HiddenKey :
            key.color = Settings.sharedInstance.GetBackgroundColorByTemplate()
            key.textColor = Settings.sharedInstance.GetBackgroundColorByTemplate()
            key.borderColor = Settings.sharedInstance.GetBackgroundColorByTemplate()
            key.hidden = true;
            key.downColor = nil
        case
        Key.KeyType.SpecialKeys :
            if(Settings.sharedInstance.currentTemplate == "My Configuration"){
                key.color = Settings.sharedInstance.SpecialKeyColor
                key.textColor = Settings.sharedInstance.SpecialKeyTextColor
                key.borderColor = Settings.sharedInstance.defaultBackgroundColor
            }
            else{
                key.color = Settings.sharedInstance.GetKeyColorByTemplate(model)
                key.textColor = Settings.sharedInstance.GetKeyTextColorByTemplate(model)
                key.borderColor = Settings.sharedInstance.GetBackgroundColorByTemplate()
            }
            key.downColor = nil
        default:
            break
        }
    }
    
    // if pool is disabled, always returns a unique key view for the corresponding key model
    func pooledKey(key aKey: Key, model: Keyboard, frame: CGRect) -> KeyboardKey? {
        if !self.dynamicType.shouldPoolKeys {
            var p: Int!
            var r: Int!
            var k: Int!
            
            var foundKey: Bool = false
            for (pp, page) in model.pages.enumerate() {
                for (rr, row) in page.rows.enumerate() {
                    for (kk, key) in row.enumerate() {
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
    
    func generateKey() -> KeyboardKey {
        let createAndSetupNewKey = { () -> KeyboardKey in
            let keyView = self.createNewKey()
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
    
    func getShape(shapeClass: Shape.Type) -> Shape {
        let className = NSStringFromClass(shapeClass)
        
        if self.dynamicType.shouldPoolKeys {
            if let shape = self.shapePool[className] {
                return shape
            }
            else {
                let shape = shapeClass.init(frame: CGRectZero)
                self.shapePool[className] = shape
                return shape
            }
        }
        else {
            return shapeClass.init(frame: CGRectZero)
        }
    }
    
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
        
        for (p, page) in model.pages.enumerate() {
            
            if p != pageToLayout {
                continue
            }
            
            let numRows = page.rows.count
            
            let mostKeysInRow: Int = {
                var currentMax: Int = 0
                for (i, row) in page.rows.enumerate() {
                    currentMax = max(currentMax, row.count)
                }
                return currentMax
                }()
            
            let rowGapTotal = CGFloat(numRows - 1 - 1) * rowGap + lastRowGap
            
            let keyGap: CGFloat = (isLandscape ? self.layoutConstants.keyGapLandscape(bounds.width, rowCharacterCount: mostKeysInRow) : self.layoutConstants.keyGapPortrait(bounds.width, rowCharacterCount: mostKeysInRow))
            
            let keyHeight: CGFloat = {
                let totalGaps = bottomEdge + topEdge + rowGapTotal
                let returnHeight = (bounds.height - totalGaps) / CGFloat(numRows)
                return self.rounded(returnHeight)
                }()
            
            let letterKeyWidth: CGFloat = {
                let totalGaps = (sideEdges * CGFloat(2)) + (keyGap * CGFloat(mostKeysInRow - 1))
                let returnWidth = (bounds.width - totalGaps) / CGFloat(mostKeysInRow)
                return self.rounded(returnWidth)
                }()
            
            let processRow = { (row: [Key], frames: [CGRect], inout map: [Key:CGRect]) -> Void in
                assert(row.count == frames.count, "row and frames don't match")
                for (k, key) in row.enumerate() {
                    map[key] = frames[k]
                }
            }
            
            for (r, row) in page.rows.enumerate() {
                let rowGapCurrentTotal = (r == page.rows.count - 1 ? rowGapTotal : CGFloat(r) * rowGap)
                let frame = CGRectMake(rounded(sideEdges), rounded(topEdge + (CGFloat(r) * keyHeight) + rowGapCurrentTotal), rounded(bounds.width - CGFloat(2) * sideEdges), rounded(keyHeight))
                
                var frames: [CGRect]!
                
                if self.characterRowHeuristic(row) {
                    frames = self.layoutCharacterRow(row, keyWidth: letterKeyWidth, gapWidth: keyGap, frame: frame)
                }
                else if self.oneLeftSidedRowHeuristic(row) {
                    frames = self.layoutCharacterWithOneSideRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
                }
                else if self.doubleLeftSidedOneRightSidedRowHeuristic(row) {
                    frames = self.layoutCharacterWithAsymetricSidesRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
                }
                else {
                    frames = layoutCharacterWithSymetricSidesRow(row, frame: frame, isLandscape: isLandscape, keyWidth: letterKeyWidth, keyGap: keyGap)
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
        
        if sideSpace < 0 {
            sideSpace = 0
            actualGapWidth = (frame.width - (CGFloat(row.count) * keyWidth)) / CGFloat(row.count - 1)
        }
        
        if sideSpace > keyWidth/CGFloat(2) {
            sideSpace = keyWidth/CGFloat(3)
        }
        
        var currentOrigin = frame.origin.x + sideSpace
        
        for (k, key) in row.enumerate() {
            let roundedOrigin = rounded(currentOrigin)
            
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
        
        for (k, key) in row.enumerate() {
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
        
        let sizeSpaceKey = CGFloat(6)*keyWidth + CGFloat(5)*keyGap
        let sizeForAllSpecialKeys = (frame.width - sizeSpaceKey - keyWidth - (CGFloat(4)*keyGap))
        let sizeOfSpecialKeyExceptOne = sizeForAllSpecialKeys/CGFloat(3)
        
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
        let keySpace = CGFloat(row.count) * keyWidth + CGFloat(row.count - 1) * keyGap
        var actualGapWidth = keyGap
        var sideSpace = (frame.width - keySpace) / CGFloat(2)
        
        if sideSpace > keyWidth/CGFloat(2) {
            sideSpace = keyWidth/CGFloat(2)
        }
        
        var currentOrigin = frame.origin.x + 1.5*sideSpace
        
        for (k, key) in row.enumerate() {
            if k == 0 {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
                currentOrigin += (keyWidth + keyGap)
            }
            else if k == row.count - 1 {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, (frame.width-currentOrigin), frame.height))
            }
            else {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, keyWidth, frame.height))
                currentOrigin += (keyWidth + keyGap)
            }
        }
        
        return frames
    }
    
    func layoutSpecialKeysRow(row: [Key], keyWidth: CGFloat, gapWidth: CGFloat, leftSideRatio: CGFloat, rightSideRatio: CGFloat, micButtonRatio: CGFloat, isLandscape: Bool, frame: CGRect) -> [CGRect] {
        var frames = [CGRect]()
        
        var keysBeforeSpace = 0
        var keysAfterSpace = 0
        var reachedSpace = false
        for (k, key) in row.enumerate() {
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
        
        let hasButtonInMicButtonPosition = (keysBeforeSpace == 3)
        
        var leftSideAreaWidth = frame.width * leftSideRatio
        let rightSideAreaWidth = frame.width * rightSideRatio
        var leftButtonWidth = (leftSideAreaWidth - (gapWidth * CGFloat(2 - 1))) / CGFloat(2)
        leftButtonWidth = rounded(leftButtonWidth)
        var rightButtonWidth = (rightSideAreaWidth - (gapWidth * CGFloat(keysAfterSpace - 1))) / CGFloat(keysAfterSpace)
        rightButtonWidth = rounded(rightButtonWidth)
        
        let micButtonWidth = (isLandscape ? leftButtonWidth : leftButtonWidth * micButtonRatio)
        
        if hasButtonInMicButtonPosition {
            leftSideAreaWidth = leftSideAreaWidth + gapWidth + micButtonWidth
        }
        
        var spaceWidth = frame.width - leftSideAreaWidth - rightSideAreaWidth - gapWidth * CGFloat(2)
        spaceWidth = rounded(spaceWidth)
        
        var currentOrigin = frame.origin.x
        var beforeSpace: Bool = true
        for (k, key) in row.enumerate() {
            if key.type == Key.KeyType.Space {
                frames.append(CGRectMake(rounded(currentOrigin), frame.origin.y, spaceWidth, frame.height))
                currentOrigin += (spaceWidth + gapWidth)
                beforeSpace = false
            }
            else if beforeSpace {
                if hasButtonInMicButtonPosition && k == 2 {
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
    
    func frameForPopup(key: KeyboardKey, direction: Direction) -> CGRect {
        let actualScreenWidth = (UIScreen.mainScreen().nativeBounds.size.width / UIScreen.mainScreen().nativeScale)
        let totalHeight = self.layoutConstants.popupTotalHeight(actualScreenWidth)
        
        let popupWidth = key.bounds.width + self.layoutConstants.popupWidthIncrement
        let popupHeight = totalHeight - self.layoutConstants.popupGap - key.bounds.height
        let popupCenterY = 0
        
        return CGRectMake((key.bounds.width - popupWidth) / CGFloat(2), -popupHeight - self.layoutConstants.popupGap, popupWidth, popupHeight)
    }
    
    func willShowPopup(key: KeyboardKey, direction: Direction) {
        if let popup = key.popup {
            let actualSuperview = (self.superview.superview != nil ? self.superview.superview! : self.superview)
            
            var localFrame = actualSuperview.convertRect(popup.frame, fromView: popup.superview)
            
            if localFrame.origin.y < 3 {
                localFrame.origin.y = 3
                
                key.background.attached = Direction.Down
                key.connector?.startDir = Direction.Down
                key.background.hideDirectionIsOpposite = true
            }
            else {
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




