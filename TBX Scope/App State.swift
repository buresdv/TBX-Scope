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
    case error
}

class AppState: ObservableObject {
    @Published var loading: LoadingState = .ready
    
    @Published var isShowingMoreInfo: Bool = false
    
    @Published var isShowingSupportSheet: Bool = false
    
    @Published var isShowingThanks: Bool = false
}

class ParsedTBX: ObservableObject {
    @Published var contents = TBX(title: "\(NSApplication.appName!)", description: "No TBX Selected", implementationFormat: 0, terms: [Term(id: "1abcd", sourceTerm: ["No TBX Selected"], targetTerm: ["No TBX Selected"], termNote: "No TBX Selected", termContext: "No TBX Selected", description: "No TBX Selected")])
}
