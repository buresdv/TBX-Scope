//
//  Purge User Defaults.swift
//  TBX Scope
//
//  Created by David Bureš on 17.10.2022.
//

import Foundation

func purgeUserDefaults() -> Void {
    let domain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: domain)
    UserDefaults.standard.synchronize()
    print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
}
