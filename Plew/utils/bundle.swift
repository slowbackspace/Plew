//
//  bundle.swift
//  Plew
//
//  Created by Maroš Špak on 02/03/2019.
//  Copyright © 2019 slowbackspace. All rights reserved.
//

import Cocoa

func getInstalledBrowsers () -> [ Bundle ] {
    var browsers = [ Bundle ]()
    
    let array = LSCopyAllHandlersForURLScheme("http" as CFString)?.takeRetainedValue()
    for i in 0..<CFArrayGetCount(array) {
        let bundleId = unsafeBitCast(CFArrayGetValueAtIndex(array, i), to: CFString.self) as String
        if let path = NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: bundleId) {
            if let bundle = Bundle(path: path) {
                browsers.append(bundle)
            }
        }
    }
    
    return browsers
}

func getDefaultBrowser () -> Bundle {
    // get the default browser bundle url
    let browserURL: URL = NSWorkspace.shared.urlForApplication(
        toOpen: URL(string: "http://example.com")!
        )!
    
    // get the browser Bundle object
    return Bundle.init(url: browserURL)!
}

func getBundleName(bundle: Bundle) -> String {
    var name: String?
    if bundle.infoDictionary?.index(forKey: "CFBundleName") != nil {
        name = bundle.infoDictionary!["CFBundleName"] as? String
    } else if bundle.infoDictionary?.index(forKey: "CFBundleDisplayName") != nil {
        name = bundle.infoDictionary!["CFBundleDisplayName"] as? String
    } else {
        print("Could not retrieve browser name");
        name = ""
    }
    return name!
}

func getBrowserImage(bundle: Bundle) -> NSImage {
    let path = NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: bundle.bundleIdentifier!);
    return NSWorkspace.shared.icon(forFile: path!)
}
