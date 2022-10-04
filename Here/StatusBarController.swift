//
//  MenuBarController.swift
//  Here
//
//  Created by Simple on 8/23/22.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
        self.popover.behavior = .transient
        
        statusBar = NSStatusBar.system
        // Creating a status bar item having a fixed length
//        statusItem = statusBar.statusItem(withLength: 28.0)
        statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        
        if let statusBarButton = statusItem.button {
            let image = NSImage(
                systemSymbolName: "sparkles",
                accessibilityDescription: nil
            )
            image?.isTemplate = true
            statusBarButton.image = image
//            statusBarButton.image = #imageLiteral(resourceName: "StatusBarIcon")
//            statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarButton.image?.isTemplate = true
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
        
    }
    
    @objc func togglePopover(sender: NSStatusBarButton) {
        sender.highlight(true)
        let event = NSApp.currentEvent
        if (event != nil && event?.type == NSEvent.EventType.leftMouseUp) {
            if(popover.isShown) {
                hidePopover(sender)
            }
            else {
                showPopover(sender)
            }
        }
    }
        
        func showPopover(_ sender: AnyObject) {
            if let statusBarButton = self.statusItem.button {
                popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
                popover.contentViewController?.view.window?.makeKey()
            }
        }
        
        func hidePopover(_ sender: AnyObject) {
            popover.performClose(sender)
        }
}
