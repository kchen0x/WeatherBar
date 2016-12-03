//
//  PreferencesWindow.swift
//  WeatherBar
//
//  Created by 陈坤 on 2016/12/2.
//  Copyright © 2016年 Kun Chen. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var cityTextField: NSTextField!
    
    var delegate: PreferencesWindowDelegate?

    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(cityTextField.stringValue, forKey: "city")
        delegate?.preferencesDidUpdate()
    }
}
