//
//  Get App Version.swift
//  TBX Scope
//
//  Created by David Bureš on 14.10.2022.
//

import Foundation
import AppKit

extension NSApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    static var buildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
