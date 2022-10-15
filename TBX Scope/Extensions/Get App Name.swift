//
//  Get App Name.swift
//  TBX Scope
//
//  Created by David Bureš on 15.10.2022.
//

import Foundation
import AppKit

extension NSApplication {
    static var appName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
