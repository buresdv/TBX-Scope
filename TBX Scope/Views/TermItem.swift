//
//  TermItem.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import SwiftUI

struct TermItem: View {
    
    @State var term: Term
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(alignment: .top) {
                VStack(alignment: .trailing) {
                    Text(term.sourceTerm.joined(separator: "\n"))
                    
                    if let termNote = term.termNote {
                        Text(termNote)
                            .font(.caption2)
                            .padding(.horizontal, 4)
                            .background(Color(NSColor.tertiaryLabelColor))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    Text(term.targetTerm.joined(separator: "\n"))
                        .font(Font.system(size: 12).italic())
                }
            }
            
            if let termDescription = term.description {
                Text(termDescription)
                    .font(.caption)
                    .foregroundColor(Color(NSColor.secondaryLabelColor))
            }
            
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .background(Color.black.opacity(0.0001)) // This hack has to be here, because if this color isn't here, the Context Menu doesn't show up. Doesn't make any fucking sense at all
        .contextMenu {
            Button {
                copyToClipboard(textToCopy: term.sourceTerm.joined())
            } label: {
                Text("Copy source term")
            }

            Button {
                copyToClipboard(textToCopy: term.targetTerm.joined(separator: ", "))
            } label: {
                if term.targetTerm.count == 1 {
                    Text("Copy target term")
                } else {
                    Text("Copy target terms")
                }
            }

        }
        .textSelection(.enabled)
        
        Divider()
    }
}

struct TermItem_Previews: PreviewProvider {
    static var previews: some View {
        TermItem(term: Term(id: "1ertz", sourceTerm: ["One", "Two"], targetTerm: ["three", "four", "five"], termNote: "Verb", termContext: "Some cool context note", description: "This is some long-ass description of what this term is about"))
    }
}
