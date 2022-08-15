//
//  Select File.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation
import AppKit

enum FilePickerResults: Error {
    case success
    case failure
}

func selectFile() throws -> URL {
    let panel = NSOpenPanel()
    
    panel.allowsMultipleSelection = false
    panel.canChooseDirectories = false
    panel.allowedFileTypes = ["tbx"]
    
    if panel.runModal() == .OK {
        return panel.url!
    } else {
        throw FilePickerResults.failure
    }
}
