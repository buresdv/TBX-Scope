//
//  TBX_ScopeApp.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import SwiftUI

@main
struct TBX_ScopeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var appState = AppState()
    @ObservedObject var parsedTBX = ParsedTBX()
    
    var body: some Scene {
        WindowGroup {
            ContentView(appState: appState, parsedTBX: parsedTBX)
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                    
                    //print("Times tipped: (called on app start)")
                    //print(UserDefaults.standard.integer(forKey: "timesTipped"))
                    
                    if UserDefaults.standard.integer(forKey: "timesTipped") == 0 {
                        appState.isShowingThanks = false
                    } else {
                        appState.isShowingThanks = true
                    }
                }
        }
        .commands {
            CommandGroup(replacing: .newItem) { }
            CommandGroup(replacing: .pasteboard) { }
            CommandGroup(replacing: .undoRedo) { }
            
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(action: {
                    appDelegate.showAboutPanel()
                }) {
                    Text("About \(NSApplication.appName!)")
                }
            }
            
            CommandGroup(after: CommandGroupPlacement.appInfo) {
                Divider()
                Button {
                    appState.isShowingSupportSheet.toggle()
                } label: {
                    Text("Support \(NSApplication.appName!)")
                }

            }
        }
    }
}
