//
//  ConfigSection.swift
//  IssieKeyboard
//
//  Created by Sasson, Kobi on 3/17/15.
//  Copyright (c) 2015 Sasson, Kobi. All rights reserved.
//

import Foundation

class ConfigSection {
    let title: String
    let items: [ConfigItem]

    init( title: String, items: [ConfigItem]){
        self.title = title
        self.items = items
    }
}