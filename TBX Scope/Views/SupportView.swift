//
//  SupportWindow.swift
//  TBX Scope
//
//  Created by David Bureš on 15.10.2022.
//

import SwiftUI

struct SupportView: View {
    
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
            HStack {
                Spacer()
                
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Text("Close")
                }

            }
        }
    }
}
