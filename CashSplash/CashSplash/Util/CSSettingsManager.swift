//
//  CSSettingsManager.swift
//  CashSplash
//
//  Created by Ivan Fabijanovic on 01/07/14.
//  Copyright (c) 2014 Ivan Fabijanovic. All rights reserved.
//

import UIKit

let kDropboxAppKey      = "dropbox_app_key"
let kDropboxAppSecret   = "dropbox_app_secret"

let kUseDropbox         = "use_dropbox"
let kDataDisplayDays    = "data_display_days"

class CSSettingsManager: NSObject {
    let appVersion: String
    let dropBoxAppKey: String
    let dropBoxAppSecret: String
    
    var useDropbox: Bool
    var dataDisplaysDays: Int
    
    // Init
    
    init() {
        let bundle = NSBundle.mainBundle()
        
        let path = bundle.pathForResource("Settings", ofType: "plist")
        let settings = NSDictionary(contentsOfFile: path)
        
        self.appVersion = bundle.objectForInfoDictionaryKey(kCFBundleVersionKey) as String
        
        self.dropBoxAppKey = settings.objectForKey(kDropboxAppKey) as String
        self.dropBoxAppSecret = settings.objectForKey(kDropboxAppSecret) as String
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        self.useDropbox = defaults.boolForKey(kUseDropbox)
        
        self.dataDisplaysDays = defaults.integerForKey(kDataDisplayDays)
        if (self.dataDisplaysDays == 0) {
            self.dataDisplaysDays = 14
            defaults.setInteger(14, forKey: kDataDisplayDays)
        }
        
        defaults.synchronize()
    }
    
    // Public methods
    
    func sync() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(self.useDropbox, forKey: kUseDropbox)
        defaults.setInteger(self.dataDisplaysDays, forKey: kDataDisplayDays)
        
        defaults.synchronize()
    }
    
    // Singleton
    
    struct Singleton {
        static var token : dispatch_once_t = 0
        static var instance : CSSettingsManager?
    }
    
    class var sharedManager: CSSettingsManager {
        dispatch_once(&Singleton.token) {
            Singleton.instance = CSSettingsManager()
        }
        return Singleton.instance!
    }
}
