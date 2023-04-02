//
//  WeatherController.swift
//  WeatherController
//
//  Created by Rajat Nagvenker on 8/8/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherController: WeatherController, weather: WeatherData)
    func didFailWithError(error: Error)
}

struct WeatherController {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f6303c1a45b7257e8b40e53444453e01&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(lattitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            
            //2. Create session
            let session = URLSession(configuration: .default)
            
            //3. Assign task to session
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4.Perform task
            task.resume()
            
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let desc = decodedData.weather[0].description
            let name = decodedData.name
            let weather = WeatherData(id: id, name: name, temp: temp, desc: desc)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
