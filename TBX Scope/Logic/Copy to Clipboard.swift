//
//  Copy to Clipboard.swift
//  TBX Scope
//
//  Created by David Bureš on 13.10.2022.
//

import Foundation
import AppKit

func copyToClipboard(textToCopy: String) -> Void {
    let pasteboard = NSPasteboard.general
    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.setString(textToCopy, forType: .string)
}
