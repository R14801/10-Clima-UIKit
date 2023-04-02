//
//  WeatherData.swift
//  Clima
//
//  Created by Rajat Nagvenker on 8/12/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var id: Int
    var name: String
    var temp: Double
    var desc: String
    var formattedTemp: String {
        return String(format: "%.1f", temp)
    }
    var condition: String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
}
