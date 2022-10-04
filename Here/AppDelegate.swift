//
//  AppDelegate.swift
//  Here
//
//  Created by Simple on 8/23/22.
//

import Foundation
import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover.init()
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the contents
        let contentView = ContentView()

        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.contentSize = NSSize(width: 275, height: 250)
        popover.contentViewController = NSHostingController(rootView: contentView)
        
        // Create the Status Bar Item with the above Popover
        statusBar = StatusBarController.init(popover)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
