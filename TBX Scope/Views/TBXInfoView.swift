//
//  TBXInfoView.swift
//  TBX Scope
//
//  Created by David Bureš on 16.08.2022.
//

import Foundation
import SwiftUI
import AppKit

struct TBXInfoView: NSViewRepresentable {
    typealias NSViewType = NSGridView
    
    var data: ParsedTBX
    
    func makeNSView(context: Context) -> NSGridView {
        var implementationFormatString: String {
            switch data.contents.implementationFormat {
            case 0:
                return "Reference"
            case 1:
                return "Microsoft"
            default:
                return "Unknown"
            }
        }
        
        let grid = NSGridView (views: [
            [NSTextField(labelWithString: "Name:"), NSTextField(wrappingLabelWithString: data.contents.title)],
            [NSTextField(labelWithString: "Description:"), NSTextField(wrappingLabelWithString: data.contents.description)],
            [NSTextField(labelWithString: "Number of terms:"), NSTextField(wrappingLabelWithString: String(data.contents.terms.count))],
            [NSTextField(labelWithString: "Implementation Format:"), NSTextField(wrappingLabelWithString: implementationFormatString)]
        ])
        
        grid.translatesAutoresizingMaskIntoConstraints = false
        grid.autoresizingMask = [.width, .height]
        
        grid.column(at: 0).xPlacement = .trailing
        
        return grid
    }
    
    func updateNSView(_ nsView: NSGridView, context: Context) {
        
    }
}
