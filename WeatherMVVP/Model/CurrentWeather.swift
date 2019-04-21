//
//  CurrentWeather.swift
//  WeatherMVVP
//
//  Created by Noh Tewolde on 4/18/19.
//  Copyright © 2019 Noh Tewolde. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let currentWeather = try? newJSONDecoder().decode(CurrentWeather.self, from: jsonData)

import Foundation

class CurrentWeather: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let id: Int?
    let name: String?
    let cod: Int?
    
    init(coord: Coord, weather: [Weather], base: String, main: Main, wind: Wind, clouds: Clouds, dt: Int, sys: Sys, id: Int, name: String, cod: Int) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.id = id
        self.name = name
        self.cod = cod
    }
}

class Clouds: Codable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
}

class Coord: Codable {
    let lon, lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

class Main: Codable {
    let temp: Double
    let pressure, humidity: Int
    let tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    init(temp: Double, pressure: Int, humidity: Int, tempMin: Double, tempMax: Double) {
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.tempMin = tempMin
        self.tempMax = tempMax
    }
}

class Sys: Codable {
    let type, id: Int
    let message: Double
    let country: String
    let sunrise, sunset: Int
    
    init(type: Int, id: Int, message: Double, country: String, sunrise: Int, sunset: Int) {
        self.type = type
        self.id = id
        self.message = message
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

class Weather: Codable {
    let id: Int
    let main, description, icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Wind: Codable {
    let speed, deg: Double
    
    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}

