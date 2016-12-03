//
//  StatusMenuController.swift
//  WeatherBar
//
//  Created by 陈坤 on 2016/12/2.
//  Copyright © 2016年 Kun Chen. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, PreferencesWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var weatherView: WeatherView!
    var weatherMenuItem: NSMenuItem!
    var preferencesWindow: PreferencesWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var weatherAPI: WeatherAPI!
    
    let DEFAULT_CITY = "Seattle, WA"
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        weatherMenuItem = statusMenu.item(withTitle: "Weather")
        weatherMenuItem.view = weatherView
        
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
        weatherAPI = WeatherAPI()
        updateWeather()
    }
    
    func updateWeather() {
        let defaults = UserDefaults.standard
        let city = defaults.string(forKey: "city") ?? DEFAULT_CITY
        weatherAPI.fetchWeather(query: city) { weather in
            self.weatherView.update(weather: weather)
        }
    }
    
    func weatherDidUpdate(weather: Weather) {
        NSLog(weather.description)
    }
    
    func preferencesDidUpdate() {
        updateWeather()
    }

    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    @IBAction func updateClicked(_ sender: Any) {
        updateWeather()
    }
    @IBAction func preferencesClicked(_ sender: Any) {
        preferencesWindow.showWindow(nil)
    }
}
