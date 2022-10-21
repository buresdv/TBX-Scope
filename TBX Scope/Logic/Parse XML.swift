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
    
    /// The implementation of the TBX format. Possible values:
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
    
    var sourceTermDescriptionPath: [XMLSubscriptType]
    var sourceTermGroupPath: [XMLSubscriptType]
    var targetTermGroupPath: [XMLSubscriptType]
    
    var termContentsPath: [XMLSubscriptType]
    
    var termNotePath: [XMLSubscriptType]
    
    switch implementationFormat {
        
    /// Reference Format
    case 0:
        sourceTermDescriptionPath = ["langSet", 0, "descripGrp", "definition"]
        sourceTermGroupPath = ["langSet", 0, "tig"]
        targetTermGroupPath = ["langSet", 1, "tig"]
        
        termContentsPath = ["term"]
        
        termNotePath = ["langSet", 0, "tig", "partOfSpeech"]
        
    /// Microsoft Format
    case 1:
        sourceTermDescriptionPath = ["langSet", 0, "descripGrp", "descrip"]
        sourceTermGroupPath = ["langSet", 0, "ntig"]
        targetTermGroupPath = ["langSet", 1, "ntig"]
        
        termContentsPath = ["termGrp", "term"]
        
        termNotePath = ["langSet", 0, "ntig", "termGrp", "termNote"]
        
    default:
        fatalError()
        
    }
    
    // Iterate over all the terms (text -> body -> termEntry)
    for hit in xml[pathToTerms] {
        var parsedSourceTermStorage = [String]()
        var parsedTargetTermStorage = [String]()
        
        let parsedTermID: String = hit.attributes["id"]!
        
        let parsedTermNote: String? = hit[termNotePath].text
        
        // Get the term's description
        let parsedTermDescription: String? = hit[sourceTermDescriptionPath].text
        
        for hit in hit[sourceTermGroupPath] {
            parsedSourceTermStorage.append(hit[termContentsPath].text!)
        }
        
        // Within all terms, iterate over their possible translations
        for hit in hit[targetTermGroupPath] {
            parsedTargetTermStorage.append(hit[termContentsPath].text!)
        }
        
        parsedTermStorage.append(Term(id: parsedTermID, sourceTerm: parsedSourceTermStorage, targetTerm: parsedTargetTermStorage, termNote: parsedTermNote, termContext: "Ahoj", description: parsedTermDescription))
    }
    
    //print(parsedTermStorage)
    
    return TBX(title: parsedTitle, description: parsedDescription, implementationFormat: implementationFormat, terms: parsedTermStorage)
}
