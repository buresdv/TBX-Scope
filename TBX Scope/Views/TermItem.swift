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
                    Text(term.termNote)
                        .font(.caption2)
                        .padding(.horizontal, 4)
                        .background(Color(NSColor.tertiaryLabelColor))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    /*ForEach(term.sourceTerm, id: \.self) { sourceTerm in
                        Text(sourceTerm)
                    }*/
                }
                
                VStack(alignment: .leading) {
                    Text(term.targetTerm.joined(separator: "\n"))
                        .font(Font.system(size: 12).italic())
                    /*ForEach(term.targetTerm, id: \.self) { targetTerm in
                        Text(targetTerm)
                    }*/
                }
            }
            
            Text(term.description)
                .font(.caption)
                .foregroundColor(Color(NSColor.secondaryLabelColor))
        }
        .padding(.horizontal)
    }
}

struct TermItem_Previews: PreviewProvider {
    static var previews: some View {
        TermItem(term: Term(id: "1ertz", sourceTerm: ["One", "Two"], targetTerm: ["three", "four", "five"], termNote: "Verb", description: "This is some long-ass description of what this term is about"))
    }
}
