//
//  Load Contents of File.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation
import SwiftUI

func loadContentsOfFile(path: URL) async throws -> String {
    let contentsOfFile: String = try String(contentsOf: path)
    return contentsOfFile
}
