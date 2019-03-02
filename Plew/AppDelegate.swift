//
//  AppDelegate.swift
//  Plew
//
//  Created by Maroš Špak on 01/03/2019.
//  Copyright © 2019 slowbackspace. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let browserList = ["Chrome", "Chromium", "Opera", "Opera Next", "Firefox", "Safari", "Safari Technology Preview"]
    
    @objc func constructMenu() {
        let menu = NSMenu()
        
        let switchItem = NSMenuItem(
            title: "Change Default Browser",
            action: nil,
            keyEquivalent: ""
        )
        
        let preferencesItem = NSMenuItem(
            title: "Preferences",
            action: nil,
            keyEquivalent: "P"
        )
        
        let quitItem = NSMenuItem(
            title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        
        //let switchSubmenu = NSMenu()
        var browserMenuItems: [MenuItemWithPayload] = []
        let browsers: [Bundle] = getInstalledBrowsers()
        let defaultBrowser: Bundle = getDefaultBrowser()
        let defaultBrowserName: String = getBundleName(bundle: defaultBrowser)
        for browser in browsers {
            let browserName: String = getBundleName(bundle: browser);
            
            if browserList.contains(browserName) {
                // add a new item to the switch browsers menu
                let menuItem = MenuItemWithPayload(
                    title: browserName,
                    action: #selector(AppDelegate.onSetDefaultBrowser(_:)),
                    keyEquivalent: "",
                    payload: browser.bundleIdentifier!
                )
                let icon: NSImage = getBrowserImage(bundle: browser)
                icon.size = NSSize.init(width: CGFloat(16), height: CGFloat(16))
                menuItem.image = icon
                menuItem.state = (browserName == defaultBrowserName)
                    ? NSControl.StateValue.on
                    : NSControl.StateValue.off
                //switchSubmenu.addItem(menuItem)
                browserMenuItems.append(menuItem)
            }
        }
        
        //switchItem.submenu = switchSubmenu
        menu.addItem(switchItem)
        browserMenuItems.sort { (item1, item2) -> Bool in
            item1.payload > item2.payload
        }
        browserMenuItems.forEach { (item) in
            menu.addItem(item)
        }
        menu.addItem(NSMenuItem.separator())
        menu.addItem(preferencesItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(quitItem)
        statusItem.menu = menu
    }

    @objc func onSetDefaultBrowser(_ sender: MenuItemWithPayload) {
        let bundleIndentifier: String = sender.payload
        let success = setDefaultBrowser(bundleId: bundleIndentifier)
        if (success) {
            print("success")
            constructMenu()
            //showNotification(title: "Default browser set!", message: "Your defalt browser has been set")
        }
    }
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target:self,
            selector: #selector(AppDelegate.constructMenu),
            userInfo: nil,
            repeats:true
        )
        RunLoop.main.add(timer, forMode: .common)
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }


}

