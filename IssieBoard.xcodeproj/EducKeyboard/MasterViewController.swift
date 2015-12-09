//
//  MasterViewController.swift
//  IssieKeyboard

//  Created by Sasson, Kobi on 3/17/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController	 {
    
    var detailViewController: DetailViewController? = nil
    //var objects = [AnyObject]()
    
    var data = [
        ConfigSection(title: "GENERAL SETTINGS" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_BACKGROUND_COLOR",           title: "background Color",      defaultValue: UIColor.whiteColor(),     type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_KEYS_COLOR",                 title: "Key Color" ,            defaultValue: UIColor.whiteColor(),     type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_TEXT_COLOR" ,                title: "Text Color" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_FONT" ,                      title: "Text Font" ,            defaultValue: "Arial",                  type: ConfigItemType.FontPicker)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_VISIBLE_KEYS",                title: "Visible Keys" ,          defaultValue: "אבגדהוזחטיכלמנסעןפצקרשתםףךץ1234567890.,?!'•_\\|~<>$€£[]{}#%^*+=.,?!'\"-/:;()₪&@",     type: ConfigItemType.String) ,
                ConfigItem(key:"ISSIE_KEYBOARD_ROW_OR_COLUMN",              title: "By rows or sections",   defaultValue: "By Sections",            type: ConfigItemType.Picker) ]),
        
        ConfigSection(title: "RIGHT/TOP KEYBOARD CONFIG" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_CHARSET1_KEYS_COLOR",        title: "Key Color" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_CHARSET1_TEXT_COLOR",        title: "Text Color" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "MIDDLE KEYBOARD CONFIG" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_CHARSET2_KEYS_COLOR",        title: "Key Color" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_CHARSET2_TEXT_COLOR",        title: "Text Color" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "LEFT/BUTTOM KEYBOARD CONFIG" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_CHARSET3_KEYS_COLOR",        title: "Key Color" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_CHARSET3_TEXT_COLOR",        title: "Text Color" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
        
        ConfigSection(title: "SPECIAL KEYS CONFIG" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT",          title: "Special Keys" ,         defaultValue: "",                       type: ConfigItemType.String)  ,
                ConfigItem(key:"ISSIE_KEYBOARD_SPECIAL_KEYS_COLOR",         title: "Key Color" ,            defaultValue: UIColor.yellowColor(),    type: ConfigItemType.Color)   ,
                ConfigItem(key:"ISSIE_KEYBOARD_SPECIAL_KEYS_TEXT_COLOR",    title: "Text Color" ,           defaultValue: UIColor.blueColor(),      type: ConfigItemType.Color)   ]),
    
        ConfigSection(title: "TEMPLATES" ,
            items: [ConfigItem(key:"ISSIE_KEYBOARD_TEMPLATES",          title: "Templates" ,         defaultValue: "" ,                       type: ConfigItemType.String)  ])
    ]
    
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
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let section = data[indexPath.section]
        let items = section.items;
        let item: ConfigItem = items[indexPath.row]
        
        cell.textLabel!.text = item.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

