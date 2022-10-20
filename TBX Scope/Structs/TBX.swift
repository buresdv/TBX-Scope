//
//  TBX.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation

struct TBX {
    var title: String
    var description: String
    
    /// The implementation of the format. Possible values:
    /// - 0: Reference format
    /// - 1: Microsoft format
    var implementationFormat: Int
    
    var terms: [Term]
}
