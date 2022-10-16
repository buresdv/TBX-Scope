//
//  AppDelegate.swift
//  TBX Scope
//
//  Created by David Bureš on 19.08.2022.
//

import AppKit
import SwiftUI
import StoreKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    private var aboutWindowController: NSWindowController?
    
    func showAboutPanel() {
        if aboutWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable, .titled]
            let window = NSWindow()
            
            window.styleMask = styleMask
            window.title = "About \(NSApplication.appName!)"
            window.contentView = NSHostingView(rootView: AboutView())
            
            aboutWindowController = NSWindowController(window: window)
        }
        
        aboutWindowController?.showWindow(aboutWindowController?.window)
    }
}
