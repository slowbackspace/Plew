//
//  automation.swift
//  Plew
//
//  Created by Maroš Špak on 02/03/2019.
//  Copyright © 2019 slowbackspace. All rights reserved.
//

import Cocoa

func setDefaultBrowser(bundleId: String) -> Bool {
    let httpResult = LSSetDefaultHandlerForURLScheme("http" as CFString, bundleId as CFString)
    let httpsResult = LSSetDefaultHandlerForURLScheme("https" as CFString, bundleId as CFString)
    if httpResult == noErr {
        confirmSetDefaultBrowserDialog()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            confirmSetDefaultBrowserDialog()
        })
        return true
    } else {
        return false
    }
}

func confirmSetDefaultBrowserDialog() {
    // TODO: click the correct button
    let myAppleScript = """
            try
              tell application "System Events"
                tell application process "CoreServicesUIAgent"
                  tell window 1
                    tell (first button whose name starts with "use")
                      perform action "AXPress"
                    end tell
                  end tell
                end tell
              end tell
            end try
        """
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: myAppleScript) {
        scriptObject.executeAndReturnError(&error)
        if error == nil {
            print("apple script success")
        } else {
            print("error: ", error!)
        }
    }
}
