//
//  AboutView.swift
//  TBX Scope
//
//  Created by David Bureš on 14.10.2022.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        HStack(alignment: .top, spacing: 20) {
            Image(nsImage: NSImage(named: "AppIcon") ?? NSImage())
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text(NSApplication.appName!)
                        .font(.title)
                    Text("Version \(NSApplication.appVersion!) (\(NSApplication.buildVersion!))")
                        .font(.caption)
                }
                
                Text("© 2022 David Bureš. All rights reserved.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Spacer()
                    
                    Button {
                        NSWorkspace.shared.open(URL(string: "https://twitter.com/davidbures")!)
                    } label: {
                        Text("Contact Me")
                    }

                }
            }
            .frame(width: 300, alignment: .topLeading)
        }
        .padding()
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
