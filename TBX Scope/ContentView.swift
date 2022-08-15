//
//  ContentView.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appState = AppState()
    @ObservedObject var parsedTBX = ParsedTBX()
    
    @State private var selectedFile: URL?
    
    var body: some View {
        VStack {
            
            if selectedFile != nil {
                Text(selectedFile!.absoluteString)
            } else {
                Text("No File Selected")
            }

            switch appState.loading {
            case .ready:
                Text("Ready to load")
            case .loading:
                Text("Loading")
            case .finished:
                Text(parsedTBX.title)
                    .font(.headline)
            }
        }
        .padding()
        .frame(minWidth: 400, minHeight: 200)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    do {
                        selectedFile = try selectFile()
                        Task {
                            do {
                                appState.loading = .loading
                                let contentsOfTBX: String = try await loadContentsOfFile(path: selectedFile!)
                                
                                
                                parsedTBX.title = try! parseXML(from: contentsOfTBX)
                                
                                appState.loading = .finished
                            } catch let error as NSError {
                                print("Failed while reading file: \(error)")
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                } label: {
                    Label("Open TBX File", systemImage: "plus")
                    
                }
            }
        }
        .navigationSubtitle(Text(parsedTBX.title))
    }
}
