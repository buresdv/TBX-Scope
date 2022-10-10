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
    
    @State private var searchString: String = ""
    
    var searchResults: [Term] {
        if searchString.isEmpty {
            return parsedTBX.contents.terms
        } else {
            /*if !parsedTBX.contents.terms.filter({ term in
                term.sourceTerm.description.localizedCaseInsensitiveContains(searchString)
            }).isEmpty {
                return parsedTBX.contents.terms.filter { term in
                    term.sourceTerm.description.localizedCaseInsensitiveContains(searchString)
                }
            } else {
                return parsedTBX.contents.terms.filter { term in
                    term.targetTerm.description.localizedCaseInsensitiveContains(searchString)
                }
            }*/
            
            return parsedTBX.contents.terms.filter({ $0.sourceTerm.description.localizedCaseInsensitiveContains(searchString) || $0.targetTerm.description.localizedCaseInsensitiveContains(searchString) })
        }
    }
    
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
                        
                        TBXInfoView(data: parsedTBX)
                            .padding()
                            .fixedSize()
                        
                    }
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(searchResults) { term in
                                TermItem(term: term)
                            }
                        }
                    }
                    .searchable(text: $searchString).keyboardShortcut("f", modifiers: [.command])
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
                .keyboardShortcut("o", modifiers: [.command])
                
                if appState.loading == .finished {
                    Button {
                        withAnimation {
                            isShowingMoreInfo.toggle()
                        }
                    } label: {
                        Label("TBX Info", systemImage: "info")
                    }
                    .keyboardShortcut("i", modifiers: [.command])
                }
            }
            
        }
        .navigationTitle(Text(parsedTBX.contents.title))
        .navigationSubtitle("\(parsedTBX.contents.terms.count == 1 ? 0 : parsedTBX.contents.terms.count) items loaded")
    }
    
    /*
    var searchResults: ParsedTBX {
        if searchString.isEmpty {
            return parsedTBX
        } else {
            return $parsedTBX.filter {
                $0.contains(searchString)
            }
        }
    }
    */
}
