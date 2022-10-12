//
//  DragPromptView.swift
//  TBX Scope
//
//  Created by David Bureš on 12.10.2022.
//

import SwiftUI

struct DragPromptView: View {
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image(systemName: "square.and.arrow.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Text("Drop TBX File Here")
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

struct DragPromptView_Previews: PreviewProvider {
    static var previews: some View {
        DragPromptView()
    }
}
