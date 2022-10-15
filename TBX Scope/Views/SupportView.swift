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
        HStack(alignment: .top, spacing: 20) {
            Image("Avatar")
                .resizable()
                .frame(width: 100, height: 100)
                .mask(Circle())
                .shadow(radius: 10)
            
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("Hey! I'm David")
                            .font(.largeTitle)
                        Text("I'm the developer of this app.")
                            .font(.subheadline)
                    }
                    
                    Text("This app is completely free and open source.\nIf you enjoy using it and would like to support it,\nyou can drop a few pennies in the tip jar.")
                    
                    Text("Who knows, there might even be a little surprise for you :)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
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
        .padding()
    }
}
