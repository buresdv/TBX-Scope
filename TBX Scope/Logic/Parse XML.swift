//
//  Parse XML.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation
import SwiftyXMLParser

func parseXML(from string: String) async throws -> TBX {
    var parsedTermStorage = [Term]()
    
    var implementationFormat: Int
    
    /// The implementation of the format. Possible values:
    /// - 0: Reference format
    /// - 1: Microsoft format
    if string.contains("<tig>") {
        implementationFormat = 0
    } else {
        implementationFormat = 1
    }
    
    let xml = try! XML.parse(string)
    
    let pathToTitle: [String] = ["martif", "martifHeader", "fileDesc", "titleStmt", "title"]
    let parsedTitle = xml[pathToTitle].text!
    
    let pathToDescription: [String] = ["martif", "martifHeader", "fileDesc", "sourceDesc", "p"]
    let parsedDescription = xml[pathToDescription].text!
    
    let pathToTerms: [String] = ["martif", "text", "body", "termEntry"]
    
    var pathToSourceDescription: [XMLSubscriptType]
    var pathToSourceTerms: [XMLSubscriptType]
    var pathToTargetTerms: [XMLSubscriptType]
    
    switch implementationFormat {
        
    /// Reference Format
    case 0:
        pathToSourceDescription = ["langSet", 0, "descripGrp", "definition"]
        pathToSourceTerms = ["langSet", 0, "tig"]
        pathToTargetTerms = ["langSet", 1, "tig"]
        
    /// Microsoft Format
    case 1:
        pathToSourceDescription = ["langSet", 0, "descripGrp", "descrip"]
        pathToSourceTerms = ["langSet", 0, "ntig"]
        pathToTargetTerms = ["langSet", 1, "ntig"]
        
    default:
        fatalError()
        
    }
    
    // Iterate over all the terms (text -> body -> termEntry)
    for hit in xml[pathToTerms] {
        var parsedSourceTermStorage = [String]()
        var parsedTargetTermStorage = [String]()
        
        let parsedTermID: String = hit.attributes["id"]!
        
        var parsedTermNote: String?
        
        switch implementationFormat {
            
        /// Reference Format
        case 0:
            parsedTermNote = hit["langSet", 0, "tig", "partOfSpeech"].text
            
        /// Microsoft Format
        case 1:
            parsedTermNote = hit["langSet", 0, "ntig", "termGrp", "termNote"].text
            
        default:
            fatalError()
        }
        
        // Get the term's description
        let parsedTermDescription: String? = hit[pathToSourceDescription].text
        
        for hit in hit[pathToSourceTerms] {
            
            switch implementationFormat {
            
            /// Reference Format
            case 0:
                parsedSourceTermStorage.append(hit["term"].text!)
                
            /// Microsoft Format
            case 1:
                parsedSourceTermStorage.append(hit["termGrp", "term"].text!)
                
            default:
                fatalError()
            }
        }
        
        // Within all terms, iterate over their possible translations
        for hit in hit[pathToTargetTerms] {
            
            switch implementationFormat {
            
            /// Reference Format
            case 0:
                parsedTargetTermStorage.append(hit["term"].text!)
                
            /// Microsoft Format
            case 1:
                parsedTargetTermStorage.append(hit["termGrp", "term"].text!)
                
            default:
                fatalError()
            }
            
        }
        
        parsedTermStorage.append(Term(id: parsedTermID, sourceTerm: parsedSourceTermStorage, targetTerm: parsedTargetTermStorage, termNote: parsedTermNote, termContext: "Ahoj", description: parsedTermDescription))
    }
    
    //print(parsedTermStorage)
    
    return TBX(title: parsedTitle, description: parsedDescription, implementationFormat: implementationFormat, terms: parsedTermStorage)
}
