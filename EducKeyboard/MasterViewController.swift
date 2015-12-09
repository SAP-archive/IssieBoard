//
//  MasterViewController.swift
//  IssieKeyboard
//
//  Created by Sasson, Kobi on 3/17/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController	 {
    
    var detailViewController: DetailViewController? = nil
    
    var data = [
        ConfigSection(title: "הגדרות ראשיות" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_BACKGROUND_COLOR",       title: "רקע המקלדת",      defaultValue: UIColor.lightGrayColor(),      type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_KEYS_COLOR",                 title: "צבע המקשים" ,            defaultValue: UIColor.brownColor(),      type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_TEXT_COLOR" ,                title: "צבע הטקסט" ,           defaultValue: UIColor.brownColor(),      type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_VISIBLE_KEYS",               title: "מקשים נראים" ,         defaultValue: "",     type: ConfigItemType.String) ,
                ConfigItem(key:"ISSIE_KEYBOARD_ROW_OR_COLUMN",              title: "שורות/עמודות",   defaultValue: "By Sections",            type: ConfigItemType.Picker) ]),
        
        ConfigSection(title: "ימינה/למעלה" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_CHARSET1_KEYS_COLOR",        title: "צבע המקשים" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_CHARSET1_TEXT_COLOR",        title: "צבע הטקסט" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "אמצע" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_CHARSET2_KEYS_COLOR",        title: "צבע המקשים" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_CHARSET2_TEXT_COLOR",        title: "צבע הטקסט" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "שמאלה/למטה" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_CHARSET3_KEYS_COLOR",        title: "צבע המקשים" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_CHARSET3_TEXT_COLOR",        title: "צבע הטקסט" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "הגדרות מקשים מיוחדים" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT",          title: "מקשים מיוחדים" ,         defaultValue: "",                       type: ConfigItemType.String)  ,
                ConfigItem(key:"ISSIE_KEYBOARD_SPECIAL_KEYS_COLOR",         title: "צבע המקשים" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT_COLOR",    title: "צבע הטקסט" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "תבניות" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_TEMPLATES",     title: "בחירת תבנית" ,    defaultValue: "My Configuration" , type: ConfigItemType.Templates)  ]),
        
        ConfigSection(title: "הגדרות נוספות" ,
            items: [
                ConfigItem(key:"ISSIE_KEYBOARD_SPACE_COLOR",          title: "צבע מקש הרווח" ,         defaultValue: UIColor.grayColor(),                       type: ConfigItemType.Color)  ,
                ConfigItem(key:"ISSIE_KEYBOARD_BACKSPACE_COLOR",          title: "צבע מקש מחיקה" ,         defaultValue: UIColor.redColor(),                       type: ConfigItemType.Color)  ,
                ConfigItem(key:"ISSIE_KEYBOARD_ENTER_COLOR",         title: "צבע מקש ירידת שורה" ,            defaultValue: UIColor.greenColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_OTHERDEFAULTKEYS_COLOR",         title: "צבע מקשים נוספים" ,            defaultValue: UIColor.grayColor(),    type: ConfigItemType.Color)   ])]
    
    func getData() -> [ConfigSection]
    {
        return data
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = data[indexPath.section].items[indexPath.row] as ConfigItem
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.configItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].items.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return data[section].title
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        let section = data[indexPath.section]
        let items = section.items;
        let item: ConfigItem = items[indexPath.row]
        
        cell.textLabel!.text = item.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

