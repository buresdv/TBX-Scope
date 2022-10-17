//
//  ContentView.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var appState: AppState
    @ObservedObject var parsedTBX: ParsedTBX
        
    @State private var selectedFile: URL?
    @State private var isShowingMoreInfo: Bool = false
    
    @State private var searchString: String = ""
    
    @State private var isDragging: Bool = false
    
    var searchResults: [Term] {
        if searchString.isEmpty {
            return parsedTBX.contents.terms
        } else {
            return parsedTBX.contents.terms.filter({ $0.sourceTerm.description.localizedCaseInsensitiveContains(searchString) || $0.targetTerm.description.localizedCaseInsensitiveContains(searchString) })
        }
    }
    
    var body: some View {
        VStack {
            switch appState.loading {
            case .ready:
                if !isDragging {
                    VStack {
                        Text("Select TBX File to Load")
                            .foregroundColor(Color(nsColor: NSColor.lightGray))
                            .font(.title)
                        
                        // TODO: This is code duplication fix it!
                        Button {
                            
                            loadUpFileData(appState: appState, parsedTBX: parsedTBX)
                            
                        } label: {
                            Text("Open TBX File")
                            
                        }
                        .keyboardShortcut("o", modifiers: [.command])
                    }
                } else {
                    DragPromptView()
                }
                
            case .loading:
                ProgressView("Loading")
                
            case .finished:
                if !isDragging {
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
                        .searchable(text: $searchString)
                    }
                } else {
                    DragPromptView()
                }
            }
        }
        .frame(minWidth: 600, minHeight: 400)
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    
                    loadUpFileData(appState: appState, parsedTBX: parsedTBX)
                    
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
        
        .onDrop(of: ["public.file-url"], isTargeted: $isDragging) { providers -> Bool in
            providers.first?.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
                if let data = data, let path = String(data: data, encoding: .utf8), let url = URL(string: path as String) {
                    
                    if url.pathExtension == "tbx" {
                        print("Correct File Format")
                        
                        loadUpFileData(appState: appState, parsedTBX: parsedTBX, manualSelectedFile: url)
                        
                    } else {
                        print("Incorrect file format")
                    }
                    
                }
            })
            return true
        }
        
        .sheet(isPresented: $appState.isShowingSupportSheet) {
            SupportView(appState: appState, isShowingSheet: $appState.isShowingSupportSheet)
        }

    }
    
}
