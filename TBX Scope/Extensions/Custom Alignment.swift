//
//  Custom Alignment.swift
//  TBX Scope
//
//  Created by David Bureš on 12.11.2022.
//

import Foundation
import SwiftUI

struct CustomAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context[.leading]
    }
}

extension HorizontalAlignment {
    static let custom: HorizontalAlignment = HorizontalAlignment(CustomAlignment.self)
}
