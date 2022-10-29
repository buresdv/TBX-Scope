//
//  Load Up File Data.swift
//  TBX Scope
//
//  Created by David Bureš on 12.10.2022.
//

import Foundation

@MainActor
func loadUpFileData(appState: AppState, parsedTBX: ParsedTBX, manualSelectedFile: URL? = nil) -> Void {
    do {
        var selectedFile: URL?
        
        /// This condition has to be here, because in case the user drags the file in, the file selection dialog never gets executed and the app crashes because this resolves to nil, while the program is still trying to move this function along because it already has a file selected
        if manualSelectedFile == nil {
            selectedFile = try selectFile()
        }
        
        Task {
            do {
                /// Make the app show it's loading
                appState.loading = .loading
                
                /// If there is a file already manually selected (e.g. when the user drags a file in), make whatever the user dragged in the selected file
                if let pathToManuallySelectedFile = manualSelectedFile {
                    selectedFile = pathToManuallySelectedFile
                }
                
                /// Load up the contents of the file
                let contentsOfTBX: String = try await loadContentsOfFile(path: selectedFile!)
                
                /// Parse the selected file
                parsedTBX.contents = try! await parseXML(from: contentsOfTBX, appState: appState)
                
                /// Make the app show the parsed result
                appState.loading = .finished
            } catch let error as NSError {
                print("Failed while reading file: \(error)")
            }
        }
    } catch let error as NSError {
        print(error)
    }
}
