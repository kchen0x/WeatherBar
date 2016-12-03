//
//  WeatherAPI.swift
//  WeatherBar
//
//  Created by 陈坤 on 2016/12/2.
//  Copyright © 2016年 Kun Chen. All rights reserved.
//

import Foundation

class WeatherAPI {
    let API_KEY = "7a0679ada300b0452fae27f9a9b71f2e"
    let BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
    
    struct Weather {
        var city: String
        var currentTemp: Float
        var conditions: String
        
        var description: String {
            return "\(city): \(currentTemp)F and \(conditions)"
        }
    }
    
    func fetchWeather(query: String) {
        let session = URLSession.shared
        // url-escape the query string we're passed
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = NSURL(string: "\(BASE_URL)?APPID=\(API_KEY)&units=imperial&q=\(escapedQuery!)")
        
        let task = session.dataTask(with: url! as URL) { data, response, error in
            // then check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let weather = self.weatherFromJSONData(data: data! as NSData) {
                        NSLog("\(weather)")
                    }
                case 401: // unauthorized
                    NSLog("weather api returned an 'unauthorized' response. Did you set your API key?")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
    
    func weatherFromJSONData(data: NSData) -> Weather? {
        typealias JSONDict = [String:AnyObject]
        let json : JSONDict
        
        do {
            json = try JSONSerialization.jsonObject(with: data as Data, options: []) as! JSONDict
        } catch {
            NSLog("JSON parsing failed: \(error)")
            return nil
        }
        
        var mainDict = json["main"] as! JSONDict
        var weatherList = json["weather"] as! [JSONDict]
        var weatherDict = weatherList[0]
        
        let weather = Weather(
            city: json["name"] as! String,
            currentTemp: mainDict["temp"] as! Float,
            conditions: weatherDict["main"] as! String
        )
        
        return weather
    }
}
