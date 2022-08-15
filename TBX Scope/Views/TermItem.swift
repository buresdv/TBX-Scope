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
                VStack(alignment: .leading) {
                    Text(term.sourceTerm.joined(separator: ", "))
                    /*ForEach(term.sourceTerm, id: \.self) { sourceTerm in
                        Text(sourceTerm)
                    }*/
                }
                
                VStack(alignment: .leading) {
                    Text(term.targetTerm.joined(separator: ", "))
                    /*ForEach(term.targetTerm, id: \.self) { targetTerm in
                        Text(targetTerm)
                    }*/
                }
            }
            
            Text(term.description)
                .font(.caption)
        }
        .padding()
    }
}

struct TermItem_Previews: PreviewProvider {
    static var previews: some View {
        TermItem(term: Term(sourceTerm: ["One", "Two"], targetTerm: ["three", "four", "five"], description: "This is some long-ass description of what this term is about"))
    }
}
