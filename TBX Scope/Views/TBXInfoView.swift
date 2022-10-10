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
        let grid = NSGridView (views: [
            [NSTextField(labelWithString: "Name:"), NSTextField(wrappingLabelWithString: data.contents.title)],
            [NSTextField(labelWithString: "Description:"), NSTextField(wrappingLabelWithString: data.contents.description)],
            [NSTextField(labelWithString: "Number of terms:"), NSTextField(wrappingLabelWithString: String(data.contents.terms.count))]
        ])
        
        grid.translatesAutoresizingMaskIntoConstraints = false
        grid.autoresizingMask = [.width, .height]
        
        grid.column(at: 0).xPlacement = .trailing
        
        /*NSLayoutConstraint.activate([
            grid.centerXAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>)
        ])*/
        
        return grid
    }
    
    func updateNSView(_ nsView: NSGridView, context: Context) {
        
    }
}
