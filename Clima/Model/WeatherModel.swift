//
//  WeatherModel.swift
//  Clima
//
//  Created by Rajat Nagvenker on 8/9/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    var weather: [Weather]
    var main: Main
    var name: String
}

struct Weather: Codable {
    var id: Int
    var description: String
}

struct Main: Codable {
    var temp: Double
}

