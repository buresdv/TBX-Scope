//
//  ErrowWhileOpeningView.swift
//  TBX Scope
//
//  Created by David Bureš on 21.10.2022.
//

import SwiftUI

struct ErrorWhileOpeningView: View {
    @State var errorText: String
    
    var body: some View {
        VStack {
            
        }
        .foregroundColor(Color(nsColor: NSColor.lightGray))
    }
}

struct ErrorWhileOpeningView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorWhileOpeningView(errorText: "Incorrect Implementation")
    }
}
