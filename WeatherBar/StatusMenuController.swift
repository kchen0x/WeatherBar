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
    @IBOutlet weak var weatherView: WeatherView!
    var weatherMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var weatherAPI: WeatherAPI!
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        weatherMenuItem = statusMenu.item(withTitle: "Weather")
        weatherMenuItem.view = weatherView
        
        weatherAPI = WeatherAPI()
        updateWeather()
    }
    
    func updateWeather() {
        weatherAPI.fetchWeather(query: "Seattle, WA") { weather in
            self.weatherView.update(weather: weather)
        }
    }
    
    func weatherDidUpdate(weather: Weather) {
        NSLog(weather.description)
    }

    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    @IBAction func updateClicked(_ sender: Any) {
        updateWeather()
    }
}
