//
//  Parse XML.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation
import SwiftyXMLParser

func parseXML(from string: String) throws -> TBX {
    var parsedTermStorage = [Term]()
    
    let xml = try! XML.parse(string)
    
    let pathToTitle: [String] = ["martif", "martifHeader", "fileDesc", "titleStmt", "title"]
    let parsedTitle = xml[pathToTitle].text!
    
    let pathToDescription: [String] = ["martif", "martifHeader", "fileDesc", "sourceDesc", "p"]
    let parsedDescription = xml[pathToDescription].text!
    
    let pathToTerms: [String] = ["martif", "text", "body", "termEntry"]
    let pathToSourceDescription: [XMLSubscriptType] = ["langSet", 0, "descripGrp", "descrip"]
    let pathToSourceTerms: [XMLSubscriptType] = ["langSet", 0, "ntig"]
    let pathToTargetTerms: [XMLSubscriptType] = ["langSet", 1, "ntig"]
    
    // Iterate over all the terms (text -> body -> termEntry)
    for hit in xml[pathToTerms] {
        var parsedSourceTermStorage = [String]()
        var parsedTargetTermStorage = [String]()
        
        let parsedTermID: String = hit.attributes["id"]!
        
        // Get the term's description
        let parsedTermDescription: String = hit[pathToSourceDescription].text ?? ""
        
        for hit in hit[pathToSourceTerms] {
            parsedSourceTermStorage.append(hit["termGrp", "term"].text!)
        }
        
        // Within all terms, iterate over their possible translations ()
        for hit in hit[pathToTargetTerms] {
            parsedTargetTermStorage.append(hit["termGrp", "term"].text!)
        }
        
        parsedTermStorage.append(Term(id: parsedTermID, sourceTerm: parsedSourceTermStorage, targetTerm: parsedTargetTermStorage, description: parsedTermDescription))
    }
    
    return TBX(title: parsedTitle, description: parsedDescription, terms: parsedTermStorage)
}
