//
//  Preferences.swift
//  eHub
//
//  Created by Gavril Tonev on 6/6/15.
//  Copyright © 2015 Gavril Tonev. All rights reserved.
//

import UIKit

private let PreferencesTeacher = "PreferencesTeacher"


final class Preferences {
    
    // MARK: Properties
    
    fileprivate class var standardUserDefaults: UserDefaults { get { return UserDefaults.standard } }
    
    class var teacher: Bool {
        get { return standardUserDefaults.bool(forKey: PreferencesTeacher) }
        set { standardUserDefaults.set(newValue, forKey: PreferencesTeacher) }
    }
    
    // Use this on App Delegate to set default settings for the application
    class func registerDefaults() {
        var defaultPreferences: [String: AnyObject] = [:]
        
        defaultPreferences[PreferencesTeacher]        = false  as AnyObject?

        standardUserDefaults.register(defaults: defaultPreferences)
    }
    
    class func reset() {
        let domainName = Bundle.main.bundleIdentifier
        standardUserDefaults.removePersistentDomain(forName: domainName!)
        Preferences.registerDefaults()
    }
}
