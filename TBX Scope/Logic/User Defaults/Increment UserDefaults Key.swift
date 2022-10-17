//
//  Increment UserDefaults Key.swift
//  TBX Scope
//
//  Created by David Bureš on 17.10.2022.
//

import Foundation

func incrementUserDefaultsKeyValue(defaults: UserDefaults, for key: String) -> Void {
    let originalKeyValue: Int = defaults.integer(forKey: key)
    
    print("Will attempt to increment key \(key), which has a value of \(originalKeyValue)")
    
    let finalKeyValue: Int = originalKeyValue + 1
    
    print("Incremented key \(key) to \(finalKeyValue)")
    
    defaults.set(finalKeyValue, forKey: key)
    
    print("Final value of key \(key): \(defaults.integer(forKey: key))")
}
