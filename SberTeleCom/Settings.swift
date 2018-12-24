//
//  Settings.swift
//  SberTeleCom
//
//  Created by Mikhail Seregin on 21.12.2018.
//  Copyright © 2018 Mikhail Seregin. All rights reserved.
//

import Foundation

class Settings {
    
    static var ipForRecognize: String {
        get {
            return UserDefaults.standard.string(forKey: "ipForRecognize") ?? ""
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "ipForRecognize")
        }
    }
    
    static var portForRecognize: Int {
        get {
            return UserDefaults.standard.integer(forKey: "portForRecognize")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "portForRecognize")
        }
    }
    
    static var login: String {
        get {
            return UserDefaults.standard.string(forKey: "login") ?? ""
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "login")
        }
    }
    
    static var password: String {
        get {
            return UserDefaults.standard.string(forKey: "password") ?? ""
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "password")
        }
    }
}
