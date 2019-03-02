//
//  menuBuilder.swift
//  Plew
//
//  Created by Maroš Špak on 02/03/2019.
//  Copyright © 2019 slowbackspace. All rights reserved.
//

import Cocoa


class MenuItemWithPayload : NSMenuItem {
    var payload: String = ""
    convenience init(title: String, action: Selector?, keyEquivalent: String, payload: String) {
        self.init()
        self.title = title
        self.action = action
        self.keyEquivalent = keyEquivalent
        self.payload = payload
    }
}


