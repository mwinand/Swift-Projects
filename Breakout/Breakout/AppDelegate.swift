//
//  AppDelegate.swift
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


// This empty class is here to fix an Xcode 9.1/9.2 bug.
// Use FooBarWindow in Main.storyboard to silence bogus error.
// Reportedly fixed in next Xcode release. See http://www.openradar.me/35511761
class FooBarWindow: NSWindow {
    
}
