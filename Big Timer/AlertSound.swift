//
//  SettingsOptions.swift
//  Big Timer
//
//  Created by Joel Klabo on 5/15/15.
//  Copyright (c) 2015 Joel Klabo. All rights reserved.
//

import UIKit

enum AlertSound: String {
    
    case Zarvox     = "zarvox"
    case Hysterical = "hysterical"
    case Bells      = "bells"
    case Trinoids   = "trinoids"
    case Boing      = "boing"
    case Cellos     = "cellos"
    case Deranged   = "deranged"
    case Bubbles    = "bubbles"
    
    static let options = [
        AlertSound.Zarvox,
        AlertSound.Hysterical,
        AlertSound.Trinoids,
        AlertSound.Boing,
        AlertSound.Cellos,
        AlertSound.Deranged,
        AlertSound.Bubbles,
        AlertSound.Bells
    ]
    
    static var selectedPreference: AlertSound {
        
        let userDefaults = UserDefaults.standard
        if let alertPreference = userDefaults.object(forKey: AlertSound.userDefaultsKey) as? String {
            return AlertSound(rawValue: alertPreference)!
        } else {
            return AlertSound.Zarvox
        }
        
    }
    
    static func setPreference (alertSound: AlertSound) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(alertSound.rawValue, forKey: AlertSound.userDefaultsKey)
        
    }
    
    var fileName: String {
        return "\(AlertSound.selectedPreference.rawValue).aiff"
    }
    
    private static var userDefaultsKey: String {
        return "alertSound"
    }
}
