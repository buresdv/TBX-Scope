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
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Text(errorText)
                    .font(.title)
                    
            }
            .foregroundColor(Color(nsColor: NSColor.lightGray))
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}

struct ErrorWhileOpeningView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorWhileOpeningView(errorText: "Incorrect TBX Implementation")
    }
}
