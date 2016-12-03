//
//  StatusMenuController.swift
//  WeatherBar
//
//  Created by 陈坤 on 2016/12/2.
//  Copyright © 2016年 Kun Chen. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    let weatherAPI = WeatherAPI()
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
    
    @IBAction func quickClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    @IBAction func updateClicked(_ sender: Any) {
        weatherAPI.fetchWeather(query: "Seattle")
    }
}
