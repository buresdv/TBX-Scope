//
//  Load Up File Data.swift
//  TBX Scope
//
//  Created by David Bureš on 12.10.2022.
//

import Foundation

@MainActor
func loadUpFileData(appState: AppState, parsedTBX: ParsedTBX) -> Void {
    do {
        let selectedFile = try selectFile()
        Task {
            do {
                appState.loading = .loading
                let contentsOfTBX: String = try await loadContentsOfFile(path: selectedFile)
                
                parsedTBX.contents = try! parseXML(from: contentsOfTBX)
                
                appState.loading = .finished
            } catch let error as NSError {
                print("Failed while reading file: \(error)")
            }
        }
    } catch let error as NSError {
        print(error)
    }
}
