//
//  DetailViewController.swift
//  IssieKeyboard
//
//  Created by Sasson, Kobi on 3/17/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var colorPalette: UIView!
    @IBOutlet weak var itemValue: UITextField!
    @IBOutlet weak var RowColPicker: UIPickerView!
    @IBOutlet weak var SaveSectionType: UIButton!
    
    var SectionType = ["By Rows", "By Sections"]
    
    var configItem: ConfigItem? {
        didSet {
            self.configureView()
        }
    }
    
    @IBAction func savePick(sender: AnyObject) {
      
        var res :String
        
        if(self.configItem?.type == ConfigItemType.Picker)
        {
            var row = RowColPicker.selectedRowInComponent(0)
            res = SectionType[row]
        }
        else
        {
            var row = RowColPicker.selectedRowInComponent(0)
            res = UIFont.familyNames()[row] as! String
        }
        
        configItem?.value = res
    }
    
    // Update the user interface for the detail item.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(self.configItem?.type == ConfigItemType.Picker)
        {
            return SectionType.count
        }
        else
        {
            return UIFont.familyNames().count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if(self.configItem?.type == ConfigItemType.Picker)
        {
            return SectionType[row]
        }
        else
        {
            return UIFont.familyNames()[row] as! String
        }
    }
    
    
    func configureView() {
        if let palette = self.colorPalette {
            if let picker = self.RowColPicker {
                palette.hidden = true
                picker.hidden = true
            }
        }
        
        if let item: ConfigItem = self.configItem {
            if let valueField = self.itemValue {
                if let palette = self.colorPalette {
                    if let picker = self.RowColPicker {
                        self.title = item.title
                        
                        switch item.type {
                        case .String:
                            valueField.enabled  = true
                            palette.hidden = true
                            valueField.text = item.value as! String
                            picker.hidden = true
                            SaveSectionType.hidden = true
                        case .Color:
                            palette.hidden = false
                            valueField.enabled = false
                            valueField.text = " "
                            valueField.backgroundColor = item.value as? UIColor
                            picker.hidden = true
                            SaveSectionType.hidden = true
                        case .Picker:
                            valueField.hidden = true
                            palette.hidden = true
                            picker.hidden = false
                        case .FontPicker:
                            valueField.hidden = true
                            palette.hidden = true
                            picker.hidden = false
                        case .Templates:
                            valueField.hidden = true
                            palette.hidden = true
                            picker.hidden = false
                        }
                    }
                }
            }
        }
        
        self.initColorRainbow()
    }
    
    @IBAction func pickColor(sender: AnyObject) {
        let popoverVC = storyboard?.instantiateViewControllerWithIdentifier("colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .Popover
        popoverVC.preferredContentSize = CGSizeMake(300, 300)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender as! UIView
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .Any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        presentViewController(popoverVC, animated: true, completion: nil)
    }
    
    func setButtonColor(color: UIColor){
        //colorPicker.backgroundColor = color;
    }
    
    func updateColor(color: UIColor) {
        if let valueField = self.itemValue {
            if let item: ConfigItem = self.configItem {
                valueField.backgroundColor = color
                item.value = color
            }
        }
    }
    
    @IBAction func valueEditingDidEnd(sender: AnyObject) {
        if let detail: ConfigItem = self.configItem {
            if let valueField = self.itemValue {
                detail.value = valueField.text
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                //colorNumberLabel.text = colorText
                self.updateColor(color)
            }
        }
    }
    
    func initColorRainbow(){
        var buttonFrame = CGRect(x: 0, y: 10, width: 25, height: 25)
        var i:CGFloat = 1.0
        while i > 0.5{
            makeRainbowButtons(buttonFrame, sat: i ,bright: 1.0)
            i = i - 0.2
            buttonFrame.origin.y = buttonFrame.origin.y + buttonFrame.size.height
        }
        
        var myButtonFrame = buttonFrame
        
        while i < 30{
            let hue:CGFloat = CGFloat(i) / 30.0
            let color = UIColor(hue: hue, saturation: 0, brightness: hue, alpha: 1.0)
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            if let view = self.colorPalette{
                view.addSubview(aButton)
            }
            
            aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
            
            i = i+2
        }
        
        let hue:CGFloat = CGFloat(1) / 13.0
        let color = UIColor(hue: hue, saturation: 0, brightness: 1, alpha: 1.0)
        let aButton = UIButton(frame: myButtonFrame)
        myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
        aButton.backgroundColor = color
        if let view = self.colorPalette{
            view.addSubview(aButton)
        }
        
        aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func makeRainbowButtons(buttonFrame:CGRect, sat:CGFloat, bright:CGFloat){
        var myButtonFrame = buttonFrame
        //populate an array of buttons
        
        for i in 0..<15{
            let hue:CGFloat = CGFloat(i) / 15.0
            let color = UIColor(hue: hue, saturation: sat, brightness: bright, alpha: 1.0)
            let aButton = UIButton(frame: myButtonFrame)
            myButtonFrame.origin.x = myButtonFrame.size.width + myButtonFrame.origin.x
            aButton.backgroundColor = color
            if let view = self.colorPalette{
                 view.addSubview(aButton)
            }
           
            aButton.addTarget(self, action: "displayColor:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
}
