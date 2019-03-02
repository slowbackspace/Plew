//
//  notification.swift
//  Plew
//
//  Created by Maroš Špak on 02/03/2019.
//  Copyright © 2019 slowbackspace. All rights reserved.
//
import Cocoa

func showNotification(title: String, message: String) -> Void {
    let notification = NSUserNotification()
    notification.title = title
    notification.informativeText = message
    notification.soundName = NSUserNotificationDefaultSoundName
    NSUserNotificationCenter.default.deliver(notification)
}
