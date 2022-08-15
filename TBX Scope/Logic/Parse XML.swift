//
//  Parse XML.swift
//  TBX Scope
//
//  Created by David Bureš on 15.08.2022.
//

import Foundation
import SwiftyXMLParser

func parseXML(from string: String) throws -> String {
    let xml = try! XML.parse(string)
    
    return xml["martif", "martifHeader", "fileDesc", "titleStmt", "title"].text!
}
