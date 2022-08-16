//
//  App State.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation
import SwiftUI

enum LoadingState {
    case ready
    case loading
    case finished
}

class AppState: ObservableObject {
    @Published var loading: LoadingState = .ready
}

class ParsedTBX: ObservableObject {
    @Published var contents = TBX(title: "TBX Scope", description: "No TBX Selected", terms: [Term(id: "1abcd", sourceTerm: ["No TBX Selected"], targetTerm: ["No TBX Selected"], termNote: "No TBX Selected", description: "No TBX Selected")])
}
