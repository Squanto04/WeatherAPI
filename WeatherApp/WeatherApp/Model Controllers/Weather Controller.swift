//
//  Weather Controller.swift
//  WeatherApp
//
//  Created by Jordan Lamb on 10/9/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

struct StringConstants {
    static let baseURL = URL(string: "http://api.openweathermap.org/data/2.5")
    static let apiKeyKey = "APPID"
    static let apiKeyValue = "0c56c4d82e5d60f733164ced8fc4ac4c"
    static let weatherComp = "weather"
    static let forecastComp = "forecast"
    static let zipQueryKey = "zip"
}

class WeatherController {
    
    static func getWeatherFor(zipcode: Int, completion: @escaping (_ weather: WeatherTLD) -> Void) {
        guard var baseURL = StringConstants.baseURL else { return }
        baseURL.appendPathComponent(StringConstants.weatherComp)
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return }
        let zipcodeQuery = URLQueryItem(name: StringConstants.zipQueryKey, value: "\(zipcode),us")
        let apiQuery = URLQueryItem(name: StringConstants.apiKeyKey, value: StringConstants.apiKeyValue)
        components.queryItems = [zipcodeQuery, apiQuery]
        guard let finalURL = components.url else { return }
        print(finalURL)
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error decoding the data\(error.localizedDescription)")
            }
            guard let data = data else { return }
            do {
                let weather = try JSONDecoder().decode(WeatherTLD.self, from: data)
                completion(weather)
            } catch {
                print("There was an error decoding to weather object: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
