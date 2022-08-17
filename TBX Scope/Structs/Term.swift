//
//  Term.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation

struct Term: Identifiable {
    let id: String
    
    let sourceTerm: [String]
    let targetTerm: [String]

    let termNote: String?
    let termContext: String?

    let description: String?
}
