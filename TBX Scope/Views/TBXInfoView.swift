//
//  TBXInfoView.swift
//  TBX Scope
//
//  Created by David Bureš on 16.08.2022.
//

import Foundation
import SwiftUI
import AppKit

struct TBXInfoViewOld: NSViewRepresentable {
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

struct TBXInfoView: View {
    @State var data: ParsedTBX
    
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
    
    var body: some View {
        
        Grid(alignment: .leading) {
            GridRow(alignment: .firstTextBaseline) {
                Text("Name:")
                    .gridColumnAlignment(.trailing)
                Text(data.contents.title)
            }
            GridRow(alignment: .firstTextBaseline) {
                Text("Description:")
                    .gridColumnAlignment(.trailing)
                Text(data.contents.description)
            }
            GridRow(alignment: .firstTextBaseline) {
                Text("Number of Terms:")
                    .gridColumnAlignment(.trailing)
                Text(String(describing: data.contents.terms.count))
            }
            GridRow(alignment: .firstTextBaseline) {
                Text("Implementation Format:")
                    .gridColumnAlignment(.trailing)
                Text(implementationFormatString)
            }
        }
        .padding()
    }
}
