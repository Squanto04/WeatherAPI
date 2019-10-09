//
//  Weather.swift
//  WeatherApp
//
//  Created by Jordan Lamb on 10/9/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

struct WeatherTLD: Decodable  {
    
    private enum CodingKeys: String, CodingKey {
        case weather
        case temps = "main"
        case visibility
        case wind
        case clouds
        case name
    }
    
    let weather: [WeatherDictionary]
    let temps: Temps
    let visibility: Int
    let wind: Wind
    let clouds: Cloud
    let name: String
}

struct WeatherDictionary: Decodable {
    let weather: Weather
}

struct Weather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title = "main"
        case description
    }
    let title: String
    let description: String
}

struct Temps: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Decodable {
    private enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
        case gust
    }
    let speed: Double
    let degrees: Int
    let gust: Double
}

struct Cloud: Decodable {
    let all: Int
}
