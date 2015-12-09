//
//  DetailViewController.swift
//  IssieKeyboard
//
//  Created by Sasson, Kobi on 3/17/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import UIKit
import QuartzCore

class DetailViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var colorPalette: UIView!
    @IBOutlet var ToggleKeyboard: UITextField!
    @IBOutlet var PreviewKeyboard: UIButton!
    @IBOutlet var RowColPicker: UISegmentedControl!
    @IBOutlet var TemplatePicker: UIStepper!
    @IBOutlet var itemValue: UITextView!
    
    var TemplateType = ["My Configuration", "Template1 - Yellow", "Template2 - Orange", "Template3", "Template4"]
    
    var configItem: ConfigItem? {
        didSet {
            self.configureView()
        }
    }
    
    @IBAction func TemplatePickerTapped(sender: UIStepper) {
        TapRecognize(sender)
        itemValue.text = TemplateType[Int(sender.value)]
        configItem?.value = TemplateType[Int(sender.value)]
    }
    
    @IBAction func TapRecognize(sender: AnyObject) {
        ToggleKeyboard.resignFirstResponder()
        itemValue.resignFirstResponder()
    }
    
    @IBAction func ChangedMode(sender: UISegmentedControl) {
        configItem?.value = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        TapRecognize(sender)
    }
    
    @IBAction func PreviewKeyboardClicked(sender: UIButton) {
        ToggleKeyboard.becomeFirstResponder()
    }
    
    func configureView() {
        
        if let toggle = self.ToggleKeyboard {
            toggle.hidden = true
        }
        
        if let item: ConfigItem = self.configItem {
            if let valueField = self.itemValue {
                if let palette = self.colorPalette {
                    if let modePicker = self.RowColPicker {
                        
                        valueField.layer.borderWidth = 1.3
                        self.title = item.title
                        
                        switch item.type {
                        case .String:
                            valueField.userInteractionEnabled  = true
                            palette.hidden = true
                            
                            if(item.title != "Visible Keys"){
                                valueField.text = item.value as! String
                            }
                            else if(item.title == "Visible Keys"){
                                if((item.value as! String) != ""){
                                    valueField.text = item.value as! String
                                }
                            }
                            
                            modePicker.hidden = true
                            TemplatePicker.hidden = true
                        case .Color:
                            TemplatePicker.hidden = true
                            palette.hidden = false
                            valueField.userInteractionEnabled = false
                            valueField.backgroundColor = item.value as? UIColor
                            modePicker.hidden = true
                        case .Picker:
                            TemplatePicker.hidden = true
                            valueField.userInteractionEnabled = true
                            valueField.hidden = true
                            palette.hidden = true
                            modePicker.hidden = false
                        case .FontPicker:
                            valueField.userInteractionEnabled = true
                            TemplatePicker.hidden = true
                            valueField.hidden = true
                            palette.hidden = true
                            modePicker.hidden = true
                        case .Templates:
                            TemplatePicker.value = 0
                            valueField.userInteractionEnabled = false
                            TemplatePicker.hidden = false
                            valueField.hidden = false
                            palette.hidden = true
                            modePicker.hidden = true
                        }
                    }
                }
            }
        }
        else
        {
            TemplatePicker.hidden = true
            colorPalette.hidden = true
            itemValue.hidden = true
            RowColPicker.hidden = true
        }
        
        self.initColorRainbow()
    }
    
    func updateColor(color: UIColor) {
        if let valueField = self.itemValue {
            if let item: ConfigItem = self.configItem {
                valueField.backgroundColor = color
                item.value = color
            }
        }
    }
    
    func textViewDidEndEditing(textView: UITextView){
    
        if let detail: ConfigItem = self.configItem {
            if let valueField = self.itemValue {
                
                if(valueField.text.isEmptyOrWhiteSpace && configItem?.title == "Visible Keys")
                {
                    detail.value = "אבגדהוזחטיכלמנסעןפצקרשתםףךץ1234567890.,?!'•_\\|~<>$€£[]{}#%^*+=.,?!'\"-/:;()₪&@";
                }
                else
                {
                    detail.value = valueField.text
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayColor(sender:UIButton){
        var r:CGFloat = 0,g:CGFloat = 0,b:CGFloat = 0
        var a:CGFloat = 0
        var h:CGFloat = 0,s:CGFloat = 0,l:CGFloat = 0
        let color = sender.backgroundColor!
        
        if color.getHue(&h, saturation: &s, brightness: &l, alpha: &a){
            if color.getRed(&r, green: &g, blue: &b, alpha: &a){
                let colorText = NSString(format: "HSB: %4.2f,%4.2f,%4.2f RGB: %4.2f,%4.2f,%4.2f",
                    Float(h),Float(s),Float(b),Float(r),Float(g),Float(b))
                self.updateColor(color)
            }
        }
    }
    
    func initColorRainbow(){
        
        var buttonFrame = CGRect(x: 0, y: 10, width: 60, height: 60)
        var i:CGFloat = 1.0
        
        let ClassicColorsLabel :UILabel = UILabel(frame: buttonFrame)
        ClassicColorsLabel.text = "Classic Colors"
        ClassicColorsLabel.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        ClassicColorsLabel.textColor = UIColor.blackColor()
        ClassicColorsLabel.sizeToFit()
        
        if let view = self.colorPalette{
            view.addSubview(ClassicColorsLabel)
        }
        
        buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height*0.5
        makeClassicColorsButtons(buttonFrame)
        buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height
        makeUIColorsButtons(buttonFrame)
        buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height + 10
        
        let RainbowColorsLabel :UILabel = UILabel(frame: buttonFrame)
        RainbowColorsLabel.text = "Rainbow Colors"
        RainbowColorsLabel.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        RainbowColorsLabel.textColor = UIColor.blackColor()
        RainbowColorsLabel.sizeToFit()
        
        if let view = self.colorPalette{
            view.addSubview(RainbowColorsLabel)
        }
        
        buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height*0.5
        
        while i > 0.5{
            makeRainbowButtons(buttonFrame, sat: i ,bright: 1.0)
            i = i - 0.2
            buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height
        }
        
        buttonFrame.origin.y = buttonFrame.origin.y + 10
        
        let BWColorsLabel :UILabel = UILabel(frame: buttonFrame)
        BWColorsLabel.text = "B&W Colors"
        BWColorsLabel.font = UIFont.boldSystemFontOfSize(CGFloat(20))
        BWColorsLabel.textColor = UIColor.blackColor()
        BWColorsLabel.sizeToFit()
        
        if let view = self.colorPalette{
            view.addSubview(BWColorsLabel)
        }
        
        buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height*0.5
        
        makeBWColorsButtons(buttonFrame)
    }
    
    func makeUIColorsButtons(buttonFrame:CGRect){
        
        var myButtonFrame = buttonFrame
        var colorsArray: [UIColor] = [UIColor.blackColor(), UIColor.darkGrayColor(),UIColor.grayColor(),UIColor.lightGrayColor(), UIColor.whiteColor(), UIColor.brownColor(), UIColor.orangeColor(), UIColor.yellowColor(),UIColor.blueColor(), UIColor.purpleColor(), UIColor.greenColor()]
        
        for i in 0..<11{
            let color = colorsArray[i]
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            aButton.layer.borderColor = UIColor.whiteColor().CGColor
            aButton.layer.borderWidth = 1
            if let view = self.colorPalette{
                view.addSubview(aButton)
            }
            
            aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func makeClassicColorsButtons(buttonFrame:CGRect){
        
        var myButtonFrame = buttonFrame
        var stringColorArray :[String] = ["C70A0A","FF00BB","C800FF","4400FF","0080FF","00DDFF","11D950","EDED21","FF9500","FF6200","C27946"]
        
        for i in 0..<11{
            let color = hexStringToUIColor(stringColorArray[i])
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            aButton.layer.borderColor = UIColor.whiteColor().CGColor
            aButton.layer.borderWidth = 1

            if let view = self.colorPalette{
                view.addSubview(aButton)
            }
            
            aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func makeBWColorsButtons(buttonFrame:CGRect){
        var myButtonFrame = buttonFrame
        var i :CGFloat = 0
        
        while i < 22{
            let hue:CGFloat = CGFloat(i) / 22.0
            let color = UIColor(hue: hue, saturation: 0, brightness: hue, alpha: 1.0)
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            aButton.layer.borderColor = UIColor.whiteColor().CGColor
            aButton.layer.borderWidth = 1

            if let view = self.colorPalette{
                view.addSubview(aButton)
            }
            
            aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
            i = i + 2
        }
        
    }
    
    func makeRainbowButtons(buttonFrame:CGRect, sat:CGFloat, bright:CGFloat){
        var myButtonFrame = buttonFrame
        
        for i in 0..<11{
            let hue:CGFloat = CGFloat(i) / 11.0
            let color = UIColor(hue: hue, saturation: sat, brightness: bright, alpha: 1.0)
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            aButton.layer.borderColor = UIColor.whiteColor().CGColor
            aButton.layer.borderWidth = 1

            if let view = self.colorPalette{
                view.addSubview(aButton)
            }
            
            aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
