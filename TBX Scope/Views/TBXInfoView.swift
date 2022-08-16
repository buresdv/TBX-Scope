//
//  TBXInfoView.swift
//  TBX Scope
//
//  Created by David Bureš on 16.08.2022.
//

import Foundation
import SwiftUI

struct TBXInfoView: NSViewRepresentable {
    typealias NSViewType = NSGridView
    
    var data: ParsedTBX
    
    func makeNSView(context: Context) -> NSGridView {
        let grid = NSGridView (views: [
            [NSTextField(labelWithString: "Name:"), NSTextField(labelWithString: data.contents.title)],
            [NSTextField(labelWithString: "Description:"), NSTextField(labelWithString: data.contents.description)],
            [NSTextField(labelWithString: "Number of terms:"), NSTextField(labelWithString: String(data.contents.terms.count))]
        ])
        
        grid.translatesAutoresizingMaskIntoConstraints = false
        
        grid.column(at: 0).xPlacement = .trailing
        
        
        
        return grid
    }
    
    func updateNSView(_ nsView: NSGridView, context: Context) {
        
    }
}
