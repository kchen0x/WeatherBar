//
//  WeatherView.swift
//  WeatherBar
//
//  Created by 陈坤 on 2016/12/2.
//  Copyright © 2016年 Kun Chen. All rights reserved.
//

import Cocoa

class WeatherView: NSView {
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var cityTextField: NSTextField!
    @IBOutlet weak var currentConditionsTextField: NSTextField!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func update(weather: Weather) {
        // do UI updates on the main thread
        DispatchQueue.global().async {
            self.cityTextField.stringValue = weather.city
            self.currentConditionsTextField.stringValue = "\(Int(weather.currentTemp))°F and \(weather.conditions)"
            self.imageView.image = NSImage(named: weather.icon)
        }
    }
}
