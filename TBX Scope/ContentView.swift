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
    @State private var isShowingMoreInfo: Bool = false
    
    var body: some View {
        VStack {
            switch appState.loading {
            case .ready:
                Text("Ready to load")
            case .loading:
                ProgressView()
                Text("Loading")
            case .finished:
                
                VStack {
                    
                    if isShowingMoreInfo {

                        VStack {
                            Text(parsedTBX.contents.description)
                        }
                        .padding(1)
                        
                    }
                    List {
                        ForEach(parsedTBX.contents.terms) { term in
                            TermItem(term: term)
                        }
                    }
                }
            }
        }
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
                                
                                
                                parsedTBX.contents = try! parseXML(from: contentsOfTBX)
                                
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
                
                if appState.loading == .finished {
                    Button {
                        withAnimation {
                            isShowingMoreInfo.toggle()
                        }
                    } label: {
                        Label("TBX Info", systemImage: "info")
                    }
                }
            }
        }
        .navigationTitle(Text(parsedTBX.contents.title))
        .navigationSubtitle("\(parsedTBX.contents.terms.count == 1 ? 0 : parsedTBX.contents.terms.count) items loaded")
    }
}
